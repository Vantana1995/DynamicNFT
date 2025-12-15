// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Base64 } from "@openzeppelin/utils/Base64.sol";
import { Strings } from "@openzeppelin/utils/Strings.sol";
import { ERC721SeaDrop } from "@seadrop/ERC721SeaDrop.sol";
import { SVG } from "./SVG.sol";
import { ENSManager } from "./ensManager.sol";

contract NFTCard is ERC721SeaDrop, SVG, ENSManager {
    

    constructor(address[] memory _allowedSeaDrop, address _registrar, address _ens) 
        ERC721SeaDrop('MrPiculeFam', 'MPF', _allowedSeaDrop)
        ENSManager(_registrar, _ens) {
        _safeMint(msg.sender, 1);
    }


    function tokenURI(uint256 _tokenId) public view override returns(string memory) {
        if (!_exists(_tokenId)) revert URIQueryForNonexistentToken();
        address owner = ownerOf(_tokenId);
        string memory baseSVGURI = _base64Convert(owner);
        string memory tokenMetadata = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"', name(),
                            '","description":"Dynamical SVG NFT representation by Mr.Picule"',
                            ',"attributes":[{"trait_type":"UserCard"}]',
                            ',"external_url":"https://github.com/Vantana1995/DynamicNFT"',
                            ',"image":"data:image/svg+xml;base64,', baseSVGURI, '"}'
                        )
                    )
                )
            )
        );
        return tokenMetadata;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }


    function _base64Convert(address _owner) private view returns (string memory _svg) {    
        string memory ownerStr = _getOwnerString(_owner);
        string memory header = _createHeaderAndBackground();
        (string memory balanceStr, string memory text2) = _generateText(_owner);

        _svg = Base64.encode(bytes(string.concat(
            header,
            BALANCE_START,
            balanceStr,
            TEXT_END,
            TEXT2_START,
            text2,
            TEXT_END,
            OWNER_START,
            ownerStr,
            TEXT_END,
            SVG_END
        )));
    }

    function _getOwnerString(address _owner) private view returns (string memory ownerStr) {
        (bool _hasName, string memory _name) = getName(_owner);
        if (_hasName) {
            ownerStr = _name;
        } else {
            ownerStr = Strings.toHexString(uint160(_owner), 20);
        }
    }
    
    function _generateText(address _owner) private view returns (string memory balanceStr, string memory text2) {
        uint256 balance = _owner.balance;
        balanceStr = Strings.toString(balance / 1 ether);
        if (balance < 1 ether) {
            text2 = 'Try harder bro';
        } else if(balance >= 1 ether && balance < 10 ether) {
            text2 = 'Well, thats not bad';
        } else {
            text2 = 'Proof-of-Degen';
        }
    }
}