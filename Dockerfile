FROM python:3.10-slim

COPY ./pynguin/pynguin-docker.sh ./pynguin-docker.sh
RUN chmod +x ./pynguin-docker.sh

ENV PYNGUIN_DANGER_AWARE="x"

ENTRYPOINT [ "bash", "./pynguin-docker.sh" ]
