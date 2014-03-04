# mesos playground

A simple way to spin up and demo Mesos with Marathon and docker executor.

Scripts included to show examples of how to spin up a new docker container.

Example to run a docker registry:

    vagrant up
    cd scripts
    ./create-app ../deploy/registry.json
