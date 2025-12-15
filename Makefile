-include .env

.PHONY: test test-debug deploy-sepolia deploy-mainnet help

GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m 

help:
	@echo "$(GREEN)Available commands:$(NC)"
	@echo "  $(YELLOW)make test$(NC)          - Run tests with verbose output (-vvvv)"
	@echo "  $(YELLOW)make test-debug$(NC)    - Run tests with debug mode"
	@echo "  $(YELLOW)make deploy-sepolia$(NC) - Deploy to Sepolia testnet with verification"
	@echo "  $(YELLOW)make deploy-mainnet$(NC) - Deploy to Ethereum mainnet with verification"

test:
	@echo "$(GREEN)Running tests...$(NC)"
	forge test -vvvv

test-debug:
	@echo "$(GREEN)Running tests in debug mode...$(NC)"
	forge test --debug

deploy-sepolia:
	@echo "$(YELLOW)Deploying to Sepolia...$(NC)"
	forge script script/Deploy.s.sol:DeployNFT \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		-vvvv
	@echo "$(GREEN)Deployment to Sepolia completed!$(NC)"

deploy-mainnet:
	@echo "$(RED)WARNING: Deploying to MAINNET!$(NC)"
	@read -p "Are you sure? (yes/no): " confirm && [ "$$confirm" = "yes" ] || (echo "Deployment cancelled" && exit 1)
	@echo "$(YELLOW)Deploying to Mainnet...$(NC)"
	forge script script/Deploy.s.sol:DeployNFT \
		--rpc-url $(MAINNET_RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		-vvvv
	@echo "$(GREEN)Deployment to Mainnet completed!$(NC)"