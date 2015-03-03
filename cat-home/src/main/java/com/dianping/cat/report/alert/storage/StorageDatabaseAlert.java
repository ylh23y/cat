package com.dianping.cat.report.alert.storage;

import org.unidal.lookup.annotation.Inject;

import com.dianping.cat.report.alert.AlertType;
import com.dianping.cat.system.config.StorageDatabaseRuleConfigManager;
import com.dianping.cat.system.config.StorageRuleConfigManager;

public class StorageDatabaseAlert extends AbstractStorageAlert {

	@Inject
	private StorageDatabaseRuleConfigManager m_configManager;

	@Override
	public String getName() {
		return AlertType.StorageDatabase.getName();
	}

	@Override
	protected StorageRuleConfigManager getRuleConfigManager() {
		return m_configManager;
	}

	@Override
	protected String getType() {
		return "SQL";
	}

}
