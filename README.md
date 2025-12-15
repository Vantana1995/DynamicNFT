# Dynamic NFT Card - On-chain ENS & Balance

A fully on-chain dynamic NFT that displays the owner's ENS name and ETH balance with generated text based on balance thresholds. All metadata and SVG are stored on-chain with no external dependencies.

## 🎨 Features

- **Fully On-chain**: All metadata and SVG generated on-chain
- **Dynamic Content**: Updates based on:
  - Owner's ENS name (or address if no ENS)
  - Owner's ETH balance (with 5 decimal precision)
  - Generated motivational text based on balance
- **OpenSea Compatible**: Inherits from `ERC721SeaDrop` for full marketplace compatibility
- **Modular Architecture**: Separated into three contracts for clean code organization

## 📋 Contract Address

**Mainnet**: [`[INSERT_CONTRACT_ADDRESS_HERE]`](https://etherscan.io/address/[INSERT_CONTRACT_ADDRESS_HERE])

**Sepolia Testnet**: [`0xAd7d830A332239fd95058aD058F2Db2128b56e7b`](https://sepolia.etherscan.io/address/0xAd7d830A332239fd95058aD058F2Db2128b56e7b)

## 🏗️ Architecture

The project consists of three main contracts:

### 1. NFTCard.sol (Main Contract)
The core ERC721 contract that combines all functionality and generates the dynamic tokenURI.
```solidity
contract NFTCard is ERC721SeaDrop, SVG, ENSManager
```

### 2. ENSManager.sol
Handles all ENS integration to retrieve the owner's ENS name from on-chain data.

**Key Features:**
- Queries ENS reverse registrar to get the node for an address
- Resolves the node to get the resolver address
- Retrieves the ENS name from the resolver
- Falls back to displaying the address if no ENS name exists
```solidity
function getName(address _user) public view returns (bool, string memory name)
```

### 3. SVG.sol
Contains all SVG constants and styling for the NFT card generation.

**Features:**
- Gold gradient styling
- Matte black background
- Structured text elements for balance, status text, and owner info

## 🎯 Dynamic Text Generation

The NFT displays different text based on the owner's balance:

- **< 1 ETH**: "Try harder bro"
- **1-10 ETH**: "Well, thats not bad"
- **> 10 ETH**: "Proof-of-Degen"

Balance is displayed with 5 decimal precision (e.g., "2.50000 Ether")

## 🚀 Installation

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/downloads)
- [Make](https://www.gnu.org/software/make/) (Git Bash on Windows includes make)

### Setup

1. Clone the repository:
```bash
git clone <your-repo-url>
cd NFT
```

2. Install dependencies:
```bash
forge install
```

3. Create a `.env` file in the root directory:
```bash
cp .env.example .env
```

4. Fill in your `.env` file with your credentials:
```env
# RPC URLs
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_KEY
MAINNET_RPC_URL=https://eth-mainnet.g.alchemy.com/v2/YOUR_ALCHEMY_KEY

# Private Key (WITHOUT 0x prefix)
PRIVATE_KEY=your_private_key_here

# Etherscan API Key (works for both testnet and mainnet)
ETHERSCAN_API_KEY=your_etherscan_api_key_here
```

**⚠️ Security Warning**: Never commit your `.env` file! Make sure it's in `.gitignore`.

## 🧪 Testing

Run tests with verbose output:
```bash
make test
```

Run tests with debug mode:
```bash
make test-debug
```

Or using forge directly:
```bash
forge test -vvvv
```

## 📦 Deployment

### Deploy to Sepolia Testnet
```bash
make deploy-sepolia
```

This command will:
- Compile the contracts with optimization
- Deploy to Sepolia
- Automatically verify on Etherscan
- Display gas costs and contract address

### Deploy to Ethereum Mainnet
```bash
make deploy-mainnet
```

**Note**: This command includes a confirmation prompt to prevent accidental mainnet deployments.

Expected deployment cost at 0.268 gwei: **~$5-6 USD** (based on ~6M gas)

## 📝 Makefile Commands

The project includes a Makefile for easy command execution:

| Command | Description |
|---------|-------------|
| `make test` | Run all tests with verbose output (-vvvv) |
| `make test-debug` | Run tests in debug mode for step-by-step execution |
| `make deploy-sepolia` | Deploy to Sepolia testnet with verification |
| `make deploy-mainnet` | Deploy to Ethereum mainnet with verification (includes confirmation) |
| `make help` | Display all available commands |

## 🔧 Configuration

### Foundry Configuration

The project uses aggressive optimization settings in `foundry.toml`:

- **Default profile**: `optimizer_runs = 200`, `via_ir = true`
- **Sepolia profile**: `optimizer_runs = 10000` (optimized for deployment cost)
- **Mainnet profile**: `optimizer_runs = 1000000` (maximum size optimization)

These settings reduce the contract size from 32,931 bytes to 20,814 bytes, fitting within the 24,576-byte limit.

## 🎨 SVG Generation

The NFT card features:
- **Gold gradient** styling with multiple color stops
- **Matte black background** with rounded corners
- **Dynamic balance display** with 5 decimal places
- **ENS name or address** display at the bottom
- **Status text** that changes based on balance

Example output:
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 550">

  <defs><linearGradient id="gold" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#FFD700"/><stop offset="30%" stop-color="#FFED4E"/><stop offset="50%" stop-color="#FFA500"/><stop offset="70%" stop-color="#DAA520"/><stop offset="100%" stop-color="#B8860B"/></linearGradient><linearGradient id="blackMatte" x1="0%" y1="0%" x2="0%" y2="100%"><stop offset="0%" stop-color="#151515"/><stop offset="40%" stop-color="#101010"/><stop offset="100%" stop-color="#0a0a0a"/></linearGradient></defs>


  <rect x="10" y="10" width="330" height="530" rx="20" fill="url(#blackMatte)" stroke="url(#gold)" stroke-width="20"/>


  <text x="175" y="100" text-anchor="middle" fill="url(#gold)" font-size="28" font-family="serif" letter-spacing="3">MrPicule Fam</text>


  <text x="30" y="200" text-anchor="start" fill="#FFD700" font-size="18" font-family="monospace">
    {balance} ETH
  </text>


  <text x="175" y="260" text-anchor="middle" fill="#FFD700" font-size="22" font-family="serif" font-style="italic" font-weight="bold">
    {Text2}
  </text>


  <text x="175" y="480"text-anchor="middle" fill="#777" font-size="12" font-family="monospace">
    {owner}
  </text>

</svg>

```

## 🔍 Key Technical Details

### Contract Size Optimization
- Original size: 32,931 bytes ❌
- Optimized size: 20,814 bytes ✅
- Achieved through `via_ir = true` and high `optimizer_runs`

### Gas Costs
- **Sepolia deployment**: ~4.8M gas
- **Estimated mainnet**: ~6M gas (~$5-6 at 0.268 gwei)

### ENS Integration
The contract integrates with ENS using:
- `IReverseRegistrar` - to get the node for an address
- `ENS` registry - to resolve the node to a resolver
- `INameResolver` - to get the actual name

All queries are view functions with no gas cost for reading.

## 📄 License

MIT License - see LICENSE file for details

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 🔗 Links

- [Foundry Documentation](https://book.getfoundry.sh/)
- [OpenSea SeaDrop](https://github.com/ProjectOpenSea/seadrop)
- [ENS Documentation](https://docs.ens.domains/)
- [Etherscan](https://etherscan.io/)

## 📧 Contact

Created by MrPicule - [GitHub](https://github.com/Vantana1995/DynamicNFT)

---

**Built with ❤️ using Foundry and Solidity**