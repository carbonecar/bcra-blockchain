// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceCentralBank {
    struct Asset {
        string name;
        uint256 value;
    }

    mapping(string => uint256) public activos;
    mapping(string => uint256) public pasivos;

    // Arrays auxiliares para almacenar los nombres de los activos y pasivos
    string[] public nombresActivos;
    string[] public nombresPasivos;

    // Evento para la actualización de activos/pasivos
    event ActivoActualizado(string nombre, uint256 valor);
    event PasivoActualizado(string nombre, uint256 valor);

    // Función para añadir activos
    function agregarActivo(string memory nombre, uint256 valor) public {
        if (activos[nombre] == 0) {
            // Si es un nuevo activo, lo agregamos al array de nombres
            nombresActivos.push(nombre);
        }
        activos[nombre] = valor;
        emit ActivoActualizado(nombre, valor);
    }

    // Función para añadir pasivos
    function agregarPasivo(string memory nombre, uint256 valor) public {
        if (pasivos[nombre] == 0) {
            // Si es un nuevo pasivo, lo agregamos al array de nombres
            nombresPasivos.push(nombre);
        }
        pasivos[nombre] = valor;
        emit PasivoActualizado(nombre, valor);
    }

    // Consultar activos totales
    function consultarActivos() public view returns (uint256 totalActivos) {
        totalActivos = 0;
        for (uint i = 0; i < nombresActivos.length; i++) {
            totalActivos += activos[nombresActivos[i]];
        }
    }

    // Consultar pasivos totales
    function consultarPasivos() public view returns (uint256 totalPasivos) {
        totalPasivos = 0;
        for (uint i = 0; i < nombresPasivos.length; i++) {
            totalPasivos += pasivos[nombresPasivos[i]];
        }
    }
}
