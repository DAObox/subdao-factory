// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.17;

import { PluginUUPSUpgradeable, IDAO } from "@aragon/osx/core/plugin/PluginUUPSUpgradeable.sol";
import { DAOFactory } from "@aragon/osx/framework/dao/DAOFactory.sol";
import { DAO } from "@aragon/osx/core/dao/DAO.sol";

/**
 * @title TribeFactory build 1
 * @author DAOBox (Security@DAOBox.app)
 * @notice A Plugin for the Tribe Protocol DAO that creates DAOs and SubDAOs
 */
contract TribeFactory is PluginUUPSUpgradeable {
    bytes32 public constant UPDATE_PERMISSION_ID = keccak256("UPDATE_PERMISSION");

    /// @notice The official DAO Factory maintained by Aragon
    DAOFactory public aragonFactory;

    /// @notice Initializes the plugin when build 1 is installed.
    /// @param _daoFactory The official DAO Factory maintained by Aragon
    function initialize(IDAO _dao, DAOFactory _daoFactory) external initializer {
        __PluginUUPSUpgradeable_init(_dao);
        aragonFactory = _daoFactory;
    }

    /// @notice Updates the DAOFactory instance. Caller needs UPDATE_PERMISSION.
    /// @param _daoFactory The DAOFactory instance to be updated.
    function storeNumber(DAOFactory _daoFactory) external auth(UPDATE_PERMISSION_ID) {
        aragonFactory = _daoFactory;
    }

    /// @notice This empty reserved space is put in place to allow future versions to add new variables without shifting
    /// down storage in the inheritance chain (see [OpenZepplins guide about storage
    /// gaps](https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps)).
    uint256[49] private __gap;
}
