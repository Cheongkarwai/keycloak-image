FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
# Enable health and metrics support
ENV KC_HOSTNAME_STRICT=false
ENV KC_DB=postgres
ENV KC_DB_URL=${KC_DB_URL}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KEYCLOAK_HTTPS_CERTIFICATE=https://squid-app-dr3jj.ondigitalocean.app
ENV KEYCLOAK_HTTPS_KEY=https://squid-app-dr3jj.ondigitalocean.app

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

CMD [ "start" ]
