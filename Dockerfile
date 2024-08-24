FROM cgr.dev/chainguard/python:latest-dev AS build

WORKDIR /app

COPY ./giropops-senhas/requirements.txt .

RUN pip install --upgrade setuptools \
    && pip install -r requirements.txt --user

FROM cgr.dev/chainguard/python:latest

COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

COPY ./giropops-senhas/ .

ENV REDIS_HOST=redisdb
ENV FLASK_APP=/app/app.py
# Expose the port
EXPOSE 5000

ENTRYPOINT ["python3", "-m", "flask", "run", "--host=0.0.0.0"]