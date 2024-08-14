FROM cwaffles/openpose:latest AS base

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN pip3 install flask && \
    mkdir flask

COPY flask/flask_entrypoint.py flask/flask_entrypoint.py

CMD ["python3", "flask/flask_entrypoint.py"]