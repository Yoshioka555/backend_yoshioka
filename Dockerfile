FROM python:3.11-buster
ENV PYTHONUNBUFFERED=1

WORKDIR /src

RUN pip install poetry
COPY pyproject.toml* poetry.lock* ./
RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# 必要な依存関係を直接インストール
RUN pip install uvicorn
RUN pip install fastapi
RUN pip install pytz
RUN pip install pytz
RUN pip install sqlalchemy
RUN pip install aiomysql
RUN pip install minio
RUN pip install python-multipart

ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]

