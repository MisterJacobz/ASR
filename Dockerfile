FROM jupyter/base-notebook:latest

# Copy the Jupyter notebook and data folder to the asr directory
COPY project.ipynb /home/jovyan/asr/
COPY data /home/jovyan/asr/data

# Switch to root user to install dependencies
USER root

# Install PortAudio and its development headers
RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Switch back to jovyan user
USER jovyan