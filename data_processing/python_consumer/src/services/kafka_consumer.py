"""Service used to extract data from kafka and write to parquet files"""
import os
import time
from datetime import datetime
from confluent_kafka import Consumer, KafkaError
import pyarrow as pa
import pyarrow.parquet as pq

def create_consumer(bootstrap_servers: list, group_id: str, topic: str, offset: str = 'earliest'):
    """_summary_

    Args:
        bootstrap_servers (_type_): _description_
        group_id (_type_): _description_
        topic (_type_): _description_

    Returns:
        _type_: _description_
    """
    bootstrap_servers = ",".join(bootstrap_servers)
    consumer = Consumer({
        'bootstrap.servers': '102.182.84.72:9092',
        'group.id': group_id,
        'auto.offset.reset':offset
    })
    consumer.subscribe([topic])
    return consumer

def consume_messages(consumer, batch_size=1000, timeout=10):
    """_summary_

    Args:
        consumer (_type_): _description_
        batch_size (int, optional): _description_. Defaults to 1000.
        timeout (int, optional): _description_. Defaults to 10.

    Yields:
        _type_: _description_
    """
    data = []
    last_write_time = time.time()

    try:
        while True:
            msg = consumer.poll(1.0)
            if msg is None:
                # Check if timeout has occurred
                if time.time() - last_write_time > timeout and data:
                    yield data
                    data = []
                    last_write_time = time.time()
                continue

            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    continue
                else:
                    print(msg.error())
                    break

            data.append(msg.value())

            if len(data) >= batch_size or (time.time() - last_write_time > timeout):
                yield data
                data = []
                last_write_time = time.time()

    finally:
        consumer.close()
        if data:
            yield data

def write_to_parquet(data: list, base_dir: str = '/code/data/netflow_data', output_file_prefix: str = 'netflow_data'):
    """
    Writes data to a Parquet file in a centralized location on your laptop, 
    organizing by year, month, and day, with a timestamped filename.
    
    Args:
        data (list): The data to write to Parquet.
        base_dir (str): The base directory for storing Parquet files.
        output_file_prefix (str, optional): The prefix for the Parquet file name.
                                           Defaults to 'netflow_data'.
    """
    # Get the current date to structure the directory
    current_date = datetime.now()
    year = current_date.strftime('%Y')
    month = current_date.strftime('%m')
    day = current_date.strftime('%d')

    # Define the output path based on the date
    output_path = os.path.join(base_dir, f"year={year}", f"month={month}", f"day={day}")
    os.makedirs(output_path, exist_ok=True)

    # Create a timestamped file name
    timestamp = current_date.strftime('%Y%m%d_%H%M%S')
    output_file = f"{output_file_prefix}_{timestamp}.parquet"

    # Construct the full file path
    full_file_path = os.path.join(output_path, output_file)

    # Convert the data to a PyArrow table
    table = pa.Table.from_arrays([pa.array(data)], names=['raw_data'])

    # Write the data to a new Parquet file
    pq.write_table(table, full_file_path)

    print(f"Data written to {full_file_path}")
