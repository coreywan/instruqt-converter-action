FROM python:3.9-slim

# Download list and upgrade to latest packages
RUN apt-get -y update
RUN apt-get -y upgrade

# Install Packages
RUN apt-get -y install git gcc libyaml-dev

# Clone Repository
RUN git clone https://github.com/nsthompson/instruqt-converter /instruqt-converter

# Install requirements
RUN pip install --no-cache-dir -r /instruqt-converter/requirements.txt

# Copy Entrypoint In
COPY entrypoint.sh /

ENTRYPOINT ["bash", "/entrypoint.sh"]