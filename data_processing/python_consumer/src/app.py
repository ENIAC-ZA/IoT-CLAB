"""main python entrypoint"""
from services.kafka_consumer import create_consumer, consume_messages, write_to_parquet

TOPIC = 'elastiflow-flow-codex-1.0'
BOOTSTRAP_SERVERS = ['102.182.84.72:9092', '102.182.84.72:9093', '102.182.84.72:9094']
GROUP_ID = 'netflow-group-file-extract'
OFFSET = 'earliest'


def main():
    """python main entrypoint"""
    consumer = create_consumer(
        bootstrap_servers=BOOTSTRAP_SERVERS,
        group_id=GROUP_ID,
        topic=TOPIC
    )

    output_path = './data/parquet_files'

    for data_batch in consume_messages(consumer, batch_size=1000, timeout=10):
        write_to_parquet(data_batch, base_dir='../data/netflow_data',  output_file_prefix='netflow_data')    

if __name__ == "__main__":
    main()
