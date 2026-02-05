.PHONY: help uv-sync playwright python-render python-render-auto python-render-fit publish node-render docker-build docker-shell docker-up docker-down

help:
	@printf "Common commands:\n"
	@printf "  make uv-sync            Install Python deps via uv\n"
	@printf "  make playwright         Install Playwright Chromium (Python)\n"
	@printf "  make python-render      Render demo markdown (separator)\n"
	@printf "  make python-render-auto Render demo markdown (auto-split)\n"
	@printf "  make python-render-fit  Render demo markdown (auto-fit)\n"
	@printf "  make publish            Publish example (requires .env)\n"
	@printf "  make node-render        Render demo markdown with Node\n"
	@printf "  make docker-build       Build dev image\n"
	@printf "  make docker-shell       Run dev shell\n"
	@printf "  make docker-up          Start dev container\n"
	@printf "  make docker-down        Stop dev container\n"

uv-sync:
	uv sync

playwright:
	uv run python -m playwright install chromium

python-render:
	uv run python scripts/render_xhs.py demos/content.md

python-render-auto:
	uv run python scripts/render_xhs.py demos/content.md -m auto-split

python-render-fit:
	uv run python scripts/render_xhs.py demos/content_auto_fit.md -m auto-fit

publish:
	uv run python scripts/publish_xhs.py --title "示例标题" --desc "示例描述" --images cover.png card_1.png

node-render:
	node scripts/render_xhs.js demos/content.md

docker-build:
	docker compose -f docker-compose.dev.yml build

docker-shell:
	docker compose -f docker-compose.dev.yml run --rm redbook-dev bash

docker-up:
	docker compose -f docker-compose.dev.yml up -d

docker-down:
	docker compose -f docker-compose.dev.yml down
