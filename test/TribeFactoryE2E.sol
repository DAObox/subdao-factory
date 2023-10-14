// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

import { console2 } from "forge-std/console2.sol";

import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";
import { DAO } from "@aragon/osx/core/dao/DAO.sol";
import { DAOMock } from "@aragon/osx/test/dao/DAOMock.sol";
import { IPluginSetup } from "@aragon/osx/framework/plugin/setup/PluginSetup.sol";
import { DaoUnauthorized } from "@aragon/osx/core/utils/auth.sol";
import { PluginRepo } from "@aragon/osx/framework/plugin/repo/PluginRepo.sol";

import { AragonE2E } from "./base/AragonE2E.sol";
import { TribeFactorySetup } from "../src/TribeFactorySetup.sol";
import { TribeFactory } from "../src/TribeFactory.sol";

contract TribeFactoryE2E is AragonE2E {
    // Plugin Setup Contracts
    TribeFactory internal plugin;
    TribeFactorySetup internal setup;

    // DAO Contracts
    PluginRepo internal repo;
    DAO internal dao;

    // Actors
    address internal unauthorised = account("unauthorised");

    function setUp() public virtual override {
        super.setUp();
        setup = new TribeFactorySetup();
        address _plugin;

        (dao, repo, _plugin) = deployRepoAndDao("tribefactorytest", address(setup), abi.encode(address(daoFactory)));

        plugin = TribeFactory(_plugin);
    }
}

contract TribeFactoryInitializeTest is TribeFactoryE2E {
    function setUp() public override {
        super.setUp();
    }

    function test_initialize() public {
        assertEq(address(plugin.dao()), address(dao));
        assertEq(address(plugin.aragonFactory()), address(daoFactory));
    }

    function test_reverts_if_reinitialized() public {
        vm.expectRevert("Initializable: contract is already initialized");
        plugin.initialize(dao, daoFactory);
    }
}
