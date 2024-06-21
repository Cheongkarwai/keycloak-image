FROM quay.io/keycloak/keycloak:24.0.1 as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true


WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:24.0.1
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
# Enable health and metrics support
ENV KC_HOSTNAME_URL=${KC_HOSTNAME_URL}
# ENV KC_HOSTNAME=lfhardware-keycloak-app-u9db4.ondigitalocean.app
ENV KC_HOSTNAME_ADMIN_URL=${KC_HOSTNAME_ADMIN_URL}
ENV KC_DB=${KC_DB}
ENV KC_DB_URL=${KC_DB_URL}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KC_HOSTNAME_DEBUG=true
# ENV KEYCLOAK_HTTPS_CERTIFICATE=https://lfhardware-keycloak-app-u9db4.ondigitalocean.app
# ENV KEYCLOAK_HTTPS_KEY=https://lfhardware-keycloak-app-u9db4.ondigitalocean.app
ENV KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}
ENV KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN}

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

CMD [ "start-dev" ]
