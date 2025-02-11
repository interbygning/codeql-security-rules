FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CODEQL_HOME=/usr/local/codeql

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    build-essential \
    && apt-get clean

# Install CodeQL CLI
RUN curl -L -o codeql.zip https://github.com/github/codeql-cli-binaries/releases/download/v2.20.4/codeql-linux64.zip \
    && unzip codeql.zip \
    && mv codeql $CODEQL_HOME \
    && rm codeql.zip

# Add CodeQL to PATH
ENV PATH="${CODEQL_HOME}/:${PATH}"

# Set working directory
WORKDIR /app