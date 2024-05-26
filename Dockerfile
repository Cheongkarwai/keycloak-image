FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
# Enable health and metrics support
ENV KC_HEALTH_ENABLED=${KC_HEALTH_ENABLED}
ENV KC_METRICS_ENABLED=${KC_METRICS_ENABLED}
ENV KC_HOSTNAME=${KC_HOSTNAME}
ENV KC_DB=${KC_DB}
ENV KC_DB_URL=${KC_DB_URL}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

CMD [ "start-dev" ]
