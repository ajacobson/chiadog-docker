FROM ubuntu:latest

ENV config_dir=/root/.chiadog/config.yaml

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python3 bash ca-certificates git openssl python3-pip build-essential python3-dev python3.8-venv python3.8-distutils python-is-python3

RUN echo "cloning chiadog"
RUN git clone https://github.com/ajacobson/chiadog.git \
&& cd chiadog \
&& python3 -m venv venv \
&& . ./venv/bin/activate \
&& pip3 install -r requirements.txt

WORKDIR /chiadog
ADD ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]