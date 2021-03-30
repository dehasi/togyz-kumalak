.PHONY: test
test:
	bundle exec rspec

.PHONY: document
document:
	bundle exec rspec --format documentation

