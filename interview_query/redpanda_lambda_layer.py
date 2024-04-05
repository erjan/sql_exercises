#python 3.11 is required due to some error in kafka-python
#layer is also runtime python3.11 , layer must start with "python" folder


import json

from time import sleep

import random

import socket
from kafka import KafkaProducer
import json
from faker import Faker
import threading

TOPIC_NAME = 'shin'
fake = Faker()




producer = KafkaProducer(
    bootstrap_servers=["co7bn98cr5sobr0qft8g.any.eu-central-1.mpx.prd.cloud.redpanda.com:9092"],
    security_protocol="SASL_SSL",
    sasl_mechanism="SCRAM-SHA-256",
    sasl_plain_username="erjcan",
    sasl_plain_password="PYTsQ1C3e1c01j8HYjWsFBfE8jmJjI",
    value_serializer=lambda m: json.dumps(m).encode('ascii') )
    
def generate_fake_event():
    company_name = fake.company()
    industry = fake.random_element(elements=('Technology', 'Finance', 'Healthcare', 'Retail', 'Manufacturing'))
    headquarters = fake.city() + ', ' + fake.country()
    revenue = fake.random_number(digits=4)
    employees = fake.random_number(digits=4)
    return {'source': 'lambda',  'company_name': company_name, 'industry': industry, 'headquarters': headquarters, 'revenue': revenue, 'employees': employees}

    
def lambda_handler(event, context):
    
    
    for _ in range(10):
        sleep(1)
        print('-----------LAMBDA--------------')
        print()
        event = generate_fake_event()
        print(event)
        producer.send(TOPIC_NAME, json.dumps(event))

    return {
        'statusCode': 200,
        'body': json.dumps('red panda!')
    }
