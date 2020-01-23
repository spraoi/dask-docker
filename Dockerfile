FROM continuumio/miniconda3:4.6.14

RUN conda install --yes --freeze-installed \
    -c conda-forge \
    python-blosc \
    cytoolz \
    dask==2.9.1 \
    nomkl \
    numpy==1.17.4 \
    pandas==0.25.3 \
    tini==0.18.0 \
    pysftp \
    ipykernel \
    papermill \
    mlxtend \
    tensorflow \
    ordered-set \
    && conda clean -tipsy \
    && find /opt/conda/ -type f,l -name '*.a' -delete \
    && find /opt/conda/ -type f,l -name '*.pyc' -delete \
    && find /opt/conda/ -type f,l -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -type f,l -name '*.js' -not -name '*.min.js' -delete \
    && rm -rf /opt/conda/pkgs
RUN apt-get update && apt-get install -y procps vim gcc build-essential
ADD requirements.txt .
RUN pip install -r requirements.txt --ignore-installed
ADD dist/boogiesvc-*.whl .
RUN pip install boogiesvc-*.whl
WORKDIR /code

COPY dask/prepare.sh /usr/bin/prepare.sh

RUN mkdir /opt/app


ENTRYPOINT ["tini", "-g", "--", "/usr/bin/prepare.sh"]
