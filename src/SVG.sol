// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SVG {

    string internal constant SVG_SPEC =
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 550">\n';

    string internal constant DEFS =
        '<defs>\n'
        '<linearGradient id="gold" x1="0%" y1="0%" x2="100%" y2="100%">\n'
        '<stop offset="0%" stop-color="#FFD700"/>\n'
        '<stop offset="30%" stop-color="#FFED4E"/>\n'
        '<stop offset="50%" stop-color="#FFA500"/>\n'
        '<stop offset="70%" stop-color="#DAA520"/>\n'
        '<stop offset="100%" stop-color="#B8860B"/>\n'
        '</linearGradient>\n'
        '<linearGradient id="blackMatte" x1="0%" y1="0%" x2="0%" y2="100%">\n'
        '<stop offset="0%" stop-color="#151515"/>\n'
        '<stop offset="40%" stop-color="#101010"/>\n'
        '<stop offset="100%" stop-color="#0a0a0a"/>\n'
        '</linearGradient>\n'
        '</defs>\n';

    string internal constant BACKGROUND =
        '<rect x="10" y="10" width="330" height="530" rx="20"\n'
        'fill="url(#blackMatte)" stroke="url(#gold)" stroke-width="20"/>\n';

    string internal constant HEADER =
        '<text x="175" y="100" text-anchor="middle" fill="url(#gold)"\n'
        'font-size="28" font-family="serif" letter-spacing="3">\n'
        'MrPicule Fam</text>\n';

    // dynamic values go between START / END
    string internal constant BALANCE_START =
        '<text x="30" y="200" text-anchor="start" fill="#FFD700"\n'
        'font-size="18" font-family="monospace">\n';

    string internal constant TEXT2_START =
        '<text x="175" y="260" text-anchor="middle" fill="#FFD700"\n'
        'font-size="22" font-family="serif" font-style="italic" font-weight="bold">\n';

    string internal constant OWNER_START =
        '<text x="175" y="480" text-anchor="middle" fill="#777"\n'
        'font-size="12" font-family="monospace">\n';

    string internal constant TEXT_END = '</text>\n';

    string internal constant SVG_END = '</svg>\n';

    constructor() {}

    function _createHeaderAndBackground() internal pure returns (string memory ){
        return string.concat(SVG_SPEC, DEFS, BACKGROUND,HEADER);
    }
}
