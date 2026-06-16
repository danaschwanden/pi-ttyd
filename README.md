# Pi - local agent harness

Run the [Pi](https://pi.dev/) agent harness locally in [Docker](https://www.docker.com/) and (LM Studio](https://lmstudio.ai/) via [ttyd](https://github.com/tsl0922/ttyd) in your browser - completely private and offline.

> [!NOTE]
> The procedure described below is intended and tested to work on a MacBook.
> 
> Adjust accordingly in case you run on another platform.

## Preconditions

- [Install Docker](https://docs.docker.com/get-started/get-docker/)
- [Install LM Studio](https://lmstudio.ai/)
- Download a model from [Hugging Face](https://huggingface.co/) (i.e. [Gemma4](https://huggingface.co/collections/google/gemma-4))

## Setup

After you have both Docker and LM Studio installed follow the setup procedure described below.

#### Configure LM Studio

![Download Model](./images/step_00.png)

![Load Model](./images/step_01.png)

![Pick Model](./images/step_02.png)

![Loaded Model](./images/step_03.png)


## Getting started

```bash
# Clone this repo
git clone https://github.com/danaschwanden/pi-ttyd.git

# Change to the repo folder
cd pi-ttyd

# Build the Docker image
./build.sh

# Run the Docker image
./run.sh
```
