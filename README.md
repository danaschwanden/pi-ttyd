# Pi - Local Agent Harness

Run the [Pi](https://pi.dev/) agent harness locally in [Docker](https://www.docker.com/) with [LM Studio](https://lmstudio.ai/) via [ttyd](https://github.com/tsl0922/ttyd) in your browser - completely privately and offline.

> [!NOTE]
> The procedure described below is intended and tested to work on a MacBook.
> 
> Adjust accordingly in case you run on another platform.

## Preconditions

- [Install Docker](https://docs.docker.com/get-started/get-docker/)
- [Install LM Studio](https://lmstudio.ai/)

## Configure LM Studio

After you have both Docker and LM Studio installed and running follow the setup procedure described below.

- Download a model from [Hugging Face](https://huggingface.co/) (i.e. [Gemma4](https://huggingface.co/collections/google/gemma-4))

#### Find a Model

![Find Model](./images/step_00.png)

#### Load the Model

![Load Model](./images/step_01.png)

#### Select the Model

![Select Model](./images/step_02.png)

#### Model Loaded and Serving

![Model Loaded and Serving](./images/step_03.png)


## Getting started

Executing the four steps outlined below will present you with a new browser window (see screen shot below) from where you can interact with the Pi agent harness.

> [!NOTE]
> You can run multiple Pi agent harnesses in parallel by executing `run.sh` as many times as suits your needs.
>
> Every `run.sh` execution starts a new container instance running on a dedicated port and its own browser tab.
> You can still collaborate between the Pi agent harness instances and/or your laptop via the mounted [`workspace`](./workspace) folder.

```bash
# Clone this repo
git clone https://github.com/danaschwanden/pi-ttyd.git

# Change to the repo folder
cd pi-ttyd

# Build the Docker image - run occassionally to update to latest versions
./build.sh

# Run the Docker image - this will start on a new port and open a new browser tab for every run
./run.sh
```

![Access Agent](./images/pi-agent.png)

## Optimise your Setup

Once you have your setup running you can optimise your your Pi agent harness by tuning the files in the [`agent folder`](./pi-data/agent) following the [Pi online docs](https://pi.dev/docs/latest).

For example, you can change the Model configuration in the [`models.json`](./pi-data/agent/models.json) file.

## Workspace

Your Pi agent will mount the [`workspace`](./workspace) folder. This will allow you to share the artifacts between different agent instances as well as access them from your local machine.

## Cleaning up

When you are done you can clean up by stopping (and removing) all the Pi agent harness container instances by running the command below:

```bash
docker stop $(docker ps -q --filter "name=pi-ttyd-*")
```
