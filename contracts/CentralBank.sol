// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//El contrato principal del Banco Central puede interactuar con el contrato 
//de Activos y Pasivos para reflejar en su balance cualquier ajuste necesario 
//tras cada emisión monetaria.
contract CentralBank {
    address public owner;
    uint256 public baseMonetaria;
    uint256 public lastUpdateTime;
    uint256 public annualGrowthRate = 101;  // 1% represented as 101% scaled by 100
    
    // Eventos para registro
    event BaseMonetariaActualizada(uint256 nuevaBaseMonetaria, uint256 tiempo);

    // Constructor
    constructor(uint256 initialBaseMonetaria) {
        owner = msg.sender;
        baseMonetaria = initialBaseMonetaria;
        lastUpdateTime = block.timestamp;
    }

    // Modificador para limitar la emisión anual
    modifier restrictEmision() {
        require(block.timestamp >= lastUpdateTime + 365 days, "Solo se puede ajustar anualmente.");
        _;
    }

    // Función para actualizar la base monetaria
    function emitirDinero() public restrictEmision {
        uint256 newBaseMonetaria = (baseMonetaria * annualGrowthRate) / 100;  // Incremento del 1%
        baseMonetaria = newBaseMonetaria;
        lastUpdateTime = block.timestamp;
        emit BaseMonetariaActualizada(newBaseMonetaria, block.timestamp);
    }

    // Función para consultar la base monetaria
    function consultarBaseMonetaria() public view returns (uint256) {
        return baseMonetaria;
    }
}
