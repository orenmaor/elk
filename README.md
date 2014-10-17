# A complete Logstash stack on [AWS OpsWorks](http://aws.amazon.com/opsworks/)


This is a bunch of cookbooks that will allow you to run a complete Logstash setup on a scalable 
[AWS OpsWorks](http://aws.amazon.com/opsworks/) stack. 

- Agents wil ship their logs to SQS and the Logstash server cluster uses it as an input source.
- An ElasticSearch/Kibana cluster layer (Amazon Linux) – All log messages are stored and indexed here.  Viewable on an Angular.js interface on top of ElasticSearch to search, graph etc.
- A LogStash cluster layer (Amazon Linux) – Takes the messages from the RabbitMQ fanout and puts them into ElasticSearch.

## Setting up Security Groups

Go to the **Security Groups** section (in the **VPC** area, not the regular **EC2** one).

Create a `ElasticSearch Servers` security group that allows ElasticSearch traffic between servrs
```
TCP Port      Source
--------      ------
9200-9400     sg-xxxxxxxx (ID of the All Servers security group)
9200-9400     sg-xxxxxxxx (ID of this group - ElasticSearch Servers Security Group)
```

A `Kibana Load Balancer` security group that will allow web traffic to the Kibana dashboard.

```
TCP Port      Source
--------      ------
80 (HTTP)     0.0.0.0/0
```
A `Kibana Internal` security group that will allow web traffic to the Kibana dashboard from the Load Balancers

```
TCP Port      Source
--------      ------
80 (HTTP)     sg-xxxxxxx (ID of the Kibana Load Balancer Security Group)
```

## Setting up your stack

- Set `git://github.com/orenmaor/elk.git` as a repository URL for your custom cookbooks.
- Use the following Chef custom JSON:

```json
{
 "chef_environment": "production",
    "elasticsearch": {
        "access_key" : "<IF IAM ROLE LEAVE BLANK OTHERWISE AWS KEY>",
        "secret_key" : "<IF IAM ROLE LEAVE BLANK OTHERWISE AWS SECRET KEY>",
        "region" : "<REPLACE WITH AWS REGION>"
    },
    "kibana": {
        "username": "<REPLACE WITH KIBANA USERNAME>",
        "password": "<REPLACE WITH KIBANA PASSWORD>"
    },
    "logstash": {
        "sqs_queue" : "<REPLACE ME WITH SQS QUEUE>",
        "sqs_region" : "<REPLACE ME WITH SQS REGION>""
    }
}
