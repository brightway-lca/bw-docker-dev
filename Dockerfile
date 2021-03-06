FROM jupyter/minimal-notebook

# Some stuff from https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
MAINTAINER Chris Mutel <cmutel@gmail.com>

USER $NB_USER

RUN conda install --quiet --yes wheel && \
    conda update --yes pip wheel setuptools

# Install Python 3 packages

RUN conda install -y -q -c conda-forge -c cmutel -c haasad brightway2 matplotlib-base jupyter jupyterlab 'xlrd=1.2.0' fs pandas conda-build
RUN conda build purge-all
RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN mkdir /home/jovyan/data
RUN mkdir /home/jovyan/notebooks
RUN mkdir /home/jovyan/output

ENV BRIGHTWAY2_DIR /home/jovyan/data
ENV BRIGHTWAY2_DOCKER 1
ENV BRIGHTWAY2_OUTPUT_DIR /home/jovyan/output

ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

RUN pip install https://github.com/brightway-lca/bw_processing/archive/master.zip
RUN pip install https://github.com/brightway-lca/matrix_utils/archive/main.zip
RUN pip install https://github.com/brightway-lca/brightway2-calc/archive/master.zip
RUN pip install https://github.com/brightway-lca/brightway2-data/archive/master.zip
RUN pip install https://github.com/brightway-lca/brightway2-io/archive/master.zip

USER $NB_UID

WORKDIR /home/jovyan/notebooks
