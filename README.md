# Dockerfile for Brightway 2.5 development

Based on the [Jupyter minimal notebook](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook).

## What it Gives You

* Miniconda, Python 3.8
* Development versions of [bw2calc](https://github.com/brightway-lca/brightway2-calc), [bw2data](https://github.com/brightway-lca/brightway2-data), [matrix_utils](https://github.com/brightway-lca/matrix_utils), and [bw_processing](https://github.com/brightway-lca/bw_processing).
* Unprivileged user jovyan (uid=1000, configurable, see options) in group users (gid=100) with ownership over /home/jovyan and /opt/conda
* tini as the container entrypoint and start-notebook.sh as the default command

Docker instances are ephemeral. You will almost certainly want to mount a [data volume](https://docs.docker.com/storage/volumes/).

## Usage

To run an instance of Jupyter Lab, accessible at `localhost:10000`:

    docker run --rm -p 10000:8888 -e JUPYTER_ENABLE_LAB=yes cmutel:brightway-dev

To launch into iPython or a bash terminal, use:

    docker run -it --entrypoint ipython cmutel:brightway-dev

or:

    docker run -it --entrypoint bash cmutel:brightway-dev

See the [Jupyter documentation](https://github.com/jupyter/docker-stacks) for more usage options.
