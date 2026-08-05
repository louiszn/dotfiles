for (const oldPanel of panels()) {
	oldPanel.remove();
}

const panel = new Panel();

panel.location = "top";
panel.height = 36;
panel.lengthMode = "fill";
panel.alignment = "center";
panel.hiding = "none";
panel.floating = false;

const plasmaViews = new ConfigFile(
	"plasmashellrc",
	"PlasmaViews"
);

const panelView = new ConfigFile(
	plasmaViews,
	`Panel ${panel.id}`
);

panelView.writeEntry("panelOpacity", 0);

panel.addWidget("org.kde.plasma.kickoff");
panel.addWidget("org.kde.plasma.appmenu");

panel.addWidget("org.kde.plasma.panelspacer");

const taskManager = panel.addWidget("org.kde.plasma.icontasks");
taskManager.currentConfigGroup = ["General"];
taskManager.writeConfig("launchers", "");

panel.addWidget("org.kde.plasma.panelspacer");

panel.addWidget("org.kde.plasma.pager");
panel.addWidget("org.kde.plasma.systemtray");
panel.addWidget("org.kde.plasma.digitalclock");
panel.addWidget("org.kde.plasma.minimizeall");
