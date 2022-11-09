// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//somosweb3makers sol bootcamp
// Hacer una colección de nfts de pelotas de futbol
// Cantidad: 100
// Se puede quemar 
// Se mintea  y 50% desc con POAP de web3makers
// 10 posibles colores 1 primario 1 secundario
// i.e.  100 posibles combinaciones 

contract makerBalls is ERC721, ERC721Burnable, Ownable {
    
    constructor() ERC721("makerBalls", "MKB") {}

    uint colorModulus = 10;
    uint Rand = 0;

    struct Ball {
        uint id;
        uint color1;
        uint color2;
    }

    Ball[] public balls;
    
    mapping (uint => uint) ballIdToTokenId;

    //Colores: 
    //        "azul","rojo","amarillo","verde","naranja","violeta" ,"blanco","negro","marrón","gris"

    function _generateRandomColor(uint _modulus) private returns (uint) {
        Rand++;
        uint rand = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, Rand)));
        return rand % _modulus;
    }

    function _createBall(uint _id, uint _color1, uint _color2) internal {
        balls.push(Ball(_id, _color1, _color2));
    }  

    function _createAllBalls() internal {
        
        for(uint i=0; i <= 3; i++) {
            _createBall(uint(i), _generateRandomColor(colorModulus), _generateRandomColor(colorModulus));
            ballIdToTokenId[i] = i;
        } 
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
    


}



