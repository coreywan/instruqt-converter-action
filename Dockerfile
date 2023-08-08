FROM python:3.9-slim

# Download list and upgrade to latest packages
RUN apt-get -y update
RUN apt-get -y upgrade

# Install Packages
RUN apt-get -y install git gcc libyaml-dev

# Install Instruqt Converter
#RUN pip install --no-cache-dir instruqt-converter
RUN pip install --no-cache-dir git+https://github.com/coreywan/instruqt-converter@dev-logging

# Copy Entrypoint In
COPY entrypoint.sh /

ENTRYPOINT ["bash", "/entrypoint.sh"]