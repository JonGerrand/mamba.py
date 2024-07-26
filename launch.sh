#! /bin/bash

EXECUTION_MODE=$1

function help {
    echo "---" 
    echo "Launch a local sandbox environment for Mamba.py using Docker."
    echo "---" 
    echo "Usage: ./launch.sh <execution_mode>"
    echo "execution_mode: cpu/gpu"
    echo ""
    echo "Example: ./launch.sh cpu"
    echo "" 
    echo "Note: If you get a permission denied error, make sure to grant execution permissions to the script,"
    echo "by running: 'sudo chmod +x launch.sh'"
}

function check_docker {
    if ! [ -x "$(command -v docker)" ]; then
        echo "Docker is not installed. Please install Docker and try again."
        exit 1
    fi
}

# -- Validations -- 
# Check input arguments
if [ "$#" -eq 0 ]; then
    help
    exit 0
fi
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters. Please provide the execution mode (cpu/gpu)."
    exit 1
fi
if [ "$EXECUTION_MODE" != "cpu" ] && [ "$EXECUTION_MODE" != "gpu" ]; then
    echo "Invalid execution mode selected. Please choose 'cpu' or 'gpu'."
    exit 1
fi
# Check if Docker is installed
check_docker 

# Launch the container
if [ "$EXECUTION_MODE" = "gpu" ]; then
    echo ""
    echo "Launching Mamba.py in GPU mode..."
    echo ""
    docker compose run --rm mamba-gpu 
elif [ "$EXECUTION_MODE" = "cpu" ]; then
    echo ""
    echo "Launching Mamba.py in CPU mode..."
    echo ""
    docker compose run --rm mamba-cpu
fi
