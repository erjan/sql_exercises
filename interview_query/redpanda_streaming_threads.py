
from time import sleep

import random

import socket
from kafka import KafkaProducer
import json
from faker import Faker
import threading

TOPIC_NAME = 'shin'
fake = Faker()


def produce_kafka(thread_index):
    producer = KafkaProducer(
        bootstrap_servers=["co7bn98cr5sobr0qft8g.any.eu-central-1.mpx.prd.cloud.redpanda.com:9092"],
        security_protocol="SASL_SSL",
        sasl_mechanism="SCRAM-SHA-256",
        sasl_plain_username="erjcan",
        sasl_plain_password="PYTsQ1C3e1c01j8HYjWsFBfE8jmJjI",
        value_serializer=lambda m: json.dumps(m).encode('ascii') )
    

    while True:
        sleep(4)
        batch_size = random.randint(2,5)
        print('-------------- batch_size: %d-----------------------' % batch_size)
        print()

        l = []
        for _ in range(batch_size):
            ev = generate_fake_event(thread_index)
            print(ev)
            print()
            l.append(ev)
        
        for event in l:
            producer.send(TOPIC_NAME, json.dumps(event))
    

 
def generate_fake_event(thread_index):
    company_name = fake.company()
    industry = fake.random_element(elements=('Technology', 'Finance', 'Healthcare', 'Retail', 'Manufacturing'))
    headquarters = fake.city() + ', ' + fake.country()
    revenue = fake.random_number(digits=4)
    employees = fake.random_number(digits=4)
    return {'source': 'EC2', 'thread_index':thread_index, 'company_name': company_name, 
            'industry': industry, 
            'headquarters': headquarters, 
            'revenue': revenue, 'employees': employees}


if __name__ == "__main__":
    # Start three instances of the script in separate threads
    for thread_index in range(3):
        thread = threading.Thread(target=produce_kafka, args=(thread_index,))
        thread.start()
