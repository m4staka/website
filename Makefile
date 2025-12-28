SHELL := bash
.ONESHELL:
.SHELLFLAGS := -euo pipefail -c

HUGO_PORT ?= 1313
HUGO_BIND ?= 127.0.0.1
RUN_DIR ?= .tmp
HUGO_LOG ?= $(RUN_DIR)/hugo-server.log
HUGO_PID ?= $(RUN_DIR)/hugo-server.pid
HUGO_ARGS ?= -D --disableFastRender --bind "$(HUGO_BIND)" --port "$(HUGO_PORT)"

HUGO := $(shell \
	if command -v hugo >/dev/null 2>&1; then command -v hugo; \
	elif command -v go >/dev/null 2>&1 && [ -x "$$(go env GOPATH)/bin/hugo" ]; then echo "$$(go env GOPATH)/bin/hugo"; \
	else echo hugo; \
	fi \
)

.PHONY: server serve stop

server:
	mkdir -p "$(RUN_DIR)"
	if command -v lsof >/dev/null 2>&1; then
		LISTEN_PID="$$(lsof -nP -iTCP@$(HUGO_BIND):$(HUGO_PORT) -sTCP:LISTEN -t 2>/dev/null | head -n 1 || true)"
		if [ -n "$${LISTEN_PID}" ]; then
			echo "$${LISTEN_PID}" >"$(HUGO_PID)"
			echo "Hugo server already listening on $(HUGO_BIND):$(HUGO_PORT) (pid $${LISTEN_PID})"
			exit 0
		fi
	fi
	if [ -f "$(HUGO_PID)" ] && kill -0 "$$(cat "$(HUGO_PID)")" 2>/dev/null; then
		echo "Hugo server already running (pid $$(cat "$(HUGO_PID)"))"
		exit 0
	fi
	"$(HUGO)" version
	nohup "$(HUGO)" server $(HUGO_ARGS) >"$(HUGO_LOG)" 2>&1 &
	echo $$! >"$(HUGO_PID)"
	echo "Hugo server started: http://localhost:$(HUGO_PORT)/ (pid $$(cat "$(HUGO_PID)"))"
	echo "Logs: $(HUGO_LOG)"

serve:
	$(MAKE) server
	tailscale serve --bg "$(HUGO_PORT)"
	tailscale serve status

stop:
	if [ -f "$(HUGO_PID)" ]; then
		PID="$$(cat "$(HUGO_PID)" || true)"
		if [ -n "$${PID}" ] && kill -0 "$${PID}" 2>/dev/null; then
			kill "$${PID}"
			echo "Stopped Hugo server (pid $${PID})"
		else
			echo "No running Hugo server found for pid file $(HUGO_PID)"
		fi
		rm -f "$(HUGO_PID)"
	else
		echo "No pid file found at $(HUGO_PID)"
	fi
	if command -v lsof >/dev/null 2>&1; then
		LISTEN_PIDS="$$(lsof -nP -iTCP@$(HUGO_BIND):$(HUGO_PORT) -sTCP:LISTEN -t 2>/dev/null || true)"
		if [ -n "$${LISTEN_PIDS}" ]; then
			kill $${LISTEN_PIDS} 2>/dev/null || true
			echo "Stopped listeners on $(HUGO_BIND):$(HUGO_PORT) ($${LISTEN_PIDS})"
		fi
	fi
	if command -v tailscale >/dev/null 2>&1; then
		tailscale serve reset || true
		echo "Tailscale serve reset"
	fi
