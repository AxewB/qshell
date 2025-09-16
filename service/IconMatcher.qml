pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root
    readonly property string placeholder: "stat_0"
    readonly property var appCategories: ({
        main: {
            "AudioVideo": "movie",
            "Audio": "headphones",
            "Video": "videocam",
            "Development": "code",
            "Education": "book2",
            "Game": "stadia_controller",
            "Graphics": "palette",
            "Network": "wifi",
            "Office": "article",
            "Science": "science",
            "Settings": "settings",
            "System": "settings",
            "Utility": "code"
        },

        additional: {
            "Building": "code",
            "Debugger": "code",
            "IDE": "code",
            "GUIDesigner": "code",
            "Profiling": "code",
            "RevisionControl": "code",
            "Translation": "code",
            "Calendar": "calendar_today",
            "ContactManagement": "contact_page",
            "Database": "database",
            "Dictionary": "dictionary",
            "Chart": "bar_chart",
            "Email": "mail",
            "Finance": "finance",
            "FlowChart": "account_tree",
            "PDA": "deskphone",
            "ProjectManagement": "folder_code",
            "Presentation": "slideshow",
            "Spreadsheet": "table",
            "WordProcessor": "docs",
            "2DGraphics": "draw",
            "VectorGraphics": "vector_square",
            "RasterGraphics": "image",
            "3DGraphics": "cube",
            "Scanning": "scanner",
            "OCR": "scanner",
            "Photography": "camera",
            "Publishing": "print",
            "Viewer": "docs",
            "TextTools": "text_fields",
            "DesktopSettings": "settings",
            "HardwareSettings": "settings",
            "Printing": "print",
            "PackageManager": "package2",
            "Dialup": "call",
            "InstantMessaging": "chat",
            "Chat": "chat",
            "IRCClient": "chat",
            "Feed": "rss_feed",
            "FileTransfer": "p2p",
            "HamRadio": "radio",
            "News": "rss_feed",
            "P2P": "p2p",
            "RemoteAccess": "devices",
            "Telephony": "call",
            "TelephonyTools": "dialpad",
            "VideoConference": "camera_video",
            "WebBrowser": "explore",
            "WebDevelopment": "code",
            "Midi": "piano",
            "Mixer": "instant_mix",
            "Sequencer": "automation",
            "Tuner": "radio",
            "TV": "tv",
            "AudioVideoEditing": "edit_audio",
            "Player": "music_note",
            "Recorder": "fiber_manual_record",
            "DiscBurning": "disc_full",
            "ActionGame": "stadia_controller",
            "AdventureGame": "stadia_controller",
            "ArcadeGame": "stadia_controller",
            "BoardGame": "stadia_controller",
            "BlocksGame": "stadia_controller",
            "CardGame": "stadia_controller",
            "KidsGame": "stadia_controller",
            "LogicGame": "stadia_controller",
            "RolePlaying": "stadia_controller",
            "Shooter": "stadia_controller",
            "Simulation": "stadia_controller",
            "SportsGame": "stadia_controller",
            "StrategyGame": "stadia_controller",
            "LauncherStore": "stadia_controller",
            "GameTool": "brick",
            "Art": "brush",
            "Construction": "construction",
            "Music": "music_note",
            "Languages": "g_translate",
            "ArtificialIntelligence": "neurology",
            "Astronomy": "planet",
            "Biology": "microbiology",
            "Chemistry": "labs",
            "ComputerScience": "computer",
            "DataVisualization": "area_chart",
            "Economy": "savings",
            "Electricity": "electric_bolt",
            "Geography": "landscape",
            "Geology": "volcano",
            "Geoscience": "landscape",
            "History": "history_edu",
            "Humanities": "volunteer_activism",
            "ImageProcessing": "photo_filter",
            "Literature": "book2",
            "Maps": "map",
            "Math": "calculate",
            "NumericalAnalysis": "calculate",
            "MedicalSoftware": "medical_services",
            "Physics": "orbit",
            "Robotics": "robot2",
            "Spirituality": "church",
            "Sports": "sports",
            "ParallelComputing": "memory",
            "Amusement": "comedy_mask",
            "Archiving": "archive",
            "Compression": "compress",
            "Electronics": "developer_board",
            "Emulator": "terminal",
            "Engineering": "engineering",
            "FileTools": "folder_open",
            "FileManager": "folder_open",
            "TerminalEmulator": "terminal",
            "Filesystem": "folder_open",
            "Monitor": "monitor",
            "Security": "security",
            "Accessibility": "accessibility",
            "Calculator": "calculate",
            "Clock": "schedule",
            "TextEditor": "code",
            "Documentation": "docs",
            "Adult": "no_adult_content"
        },

        reserved: {
            "Core": "help",
            "KDE": "egg",
            "COSMIC": "egg",
            "GNOME": "egg",
            "LXQt": "egg",
            "XFCE": "egg",
            "DDE": "egg",
            "GTK": "egg",
            "Qt": "egg",
            "Motif": "egg",
            "Java": "egg",
            "ConsoleOnly": "terminal",
            "Screensaver": "capture",
            "TrayIcon": "shelf_auto_hide",
            "Applet": "egg",
            "Shell": "egg"
        }
    })

    readonly property var appCategoriesParents: ({
        // main → main
        "AudioVideo": "AudioVideo",
        "Audio": "AudioVideo",
        "Video": "AudioVideo",

        "Development": "Development",
        "Building": "Development",
        "Debugger": "Development",
        "IDE": "Development",
        "GUIDesigner": "Development",
        "Profiling": "Development",
        "RevisionControl": "Development",
        "Translation": "Development",
        "WebDevelopment": "Development",
        "TextEditor": "Development",
        "Documentation": "Development",

        "Education": "Education",
        "Languages": "Education",
        "Literature": "Education",
        "History": "Education",
        "Humanities": "Education",

        "Game": "Game",
        "ActionGame": "Game",
        "AdventureGame": "Game",
        "ArcadeGame": "Game",
        "BoardGame": "Game",
        "BlocksGame": "Game",
        "CardGame": "Game",
        "KidsGame": "Game",
        "LogicGame": "Game",
        "RolePlaying": "Game",
        "Shooter": "Game",
        "Simulation": "Game",
        "SportsGame": "Game",
        "StrategyGame": "Game",
        "LauncherStore": "Game",
        "GameTool": "Game",

        "Graphics": "Graphics",
        "2DGraphics": "Graphics",
        "VectorGraphics": "Graphics",
        "RasterGraphics": "Graphics",
        "3DGraphics": "Graphics",
        "Scanning": "Graphics",
        "OCR": "Graphics",
        "Photography": "Graphics",
        "Publishing": "Graphics",
        "Viewer": "Graphics",
        "TextTools": "Graphics",
        "ImageProcessing": "Graphics",
        "Art": "Graphics",

        "Network": "Network",
        "Dialup": "Network",
        "InstantMessaging": "Network",
        "Chat": "Network",
        "IRCClient": "Network",
        "Feed": "Network",
        "FileTransfer": "Network",
        "HamRadio": "Network",
        "News": "Network",
        "P2P": "Network",
        "RemoteAccess": "Network",
        "Telephony": "Network",
        "TelephonyTools": "Network",
        "VideoConference": "Network",
        "WebBrowser": "Network",

        "Office": "Office",
        "Calendar": "Office",
        "ContactManagement": "Office",
        "Database": "Office",
        "Dictionary": "Office",
        "Chart": "Office",
        "Email": "Office",
        "Finance": "Office",
        "FlowChart": "Office",
        "PDA": "Office",
        "ProjectManagement": "Office",
        "Presentation": "Office",
        "Spreadsheet": "Office",
        "WordProcessor": "Office",

        "Science": "Science",
        "ArtificialIntelligence": "Science",
        "Astronomy": "Science",
        "Biology": "Science",
        "Chemistry": "Science",
        "ComputerScience": "Science",
        "DataVisualization": "Science",
        "Economy": "Science",
        "Electricity": "Science",
        "Geography": "Science",
        "Geology": "Science",
        "Geoscience": "Science",
        "Math": "Science",
        "NumericalAnalysis": "Science",
        "MedicalSoftware": "Science",
        "Physics": "Science",
        "Robotics": "Science",
        "Spirituality": "Science",

        "Settings": "Settings",
        "System": "System",
        "DesktopSettings": "System",
        "HardwareSettings": "System",
        "Printing": "System",
        "PackageManager": "System",
        "Monitor": "System",
        "Security": "System",
        "Accessibility": "System",
        "Calculator": "System",
        "Clock": "System",

        "Utility": "Utility",
        "Archiving": "Utility",
        "Compression": "Utility",
        "Electronics": "Utility",
        "Emulator": "Utility",
        "Engineering": "Utility",
        "FileTools": "Utility",
        "FileManager": "Utility",
        "TerminalEmulator": "Utility",
        "Filesystem": "Utility",

        // media subcategories → AudioVideo
        "Midi": "AudioVideo",
        "Mixer": "AudioVideo",
        "Sequencer": "AudioVideo",
        "Tuner": "AudioVideo",
        "TV": "AudioVideo",
        "AudioVideoEditing": "AudioVideo",
        "Player": "AudioVideo",
        "Recorder": "AudioVideo",
        "DiscBurning": "AudioVideo",
        "Music": "AudioVideo",

        // reserved
        "Core": "System",
        "KDE": "System",
        "COSMIC": "System",
        "GNOME": "System",
        "LXQt": "System",
        "XFCE": "System",
        "DDE": "System",
        "GTK": "System",
        "Qt": "System",
        "Motif": "System",
        "Java": "Development",
        "ConsoleOnly": "System",
        "Screensaver": "System",
        "TrayIcon": "System",
        "Applet": "System",
        "Shell": "System",

        // extras
        "Amusement": "Utility",
        "Adult": "Utility"
    })


    // additional → reserved → main → placeholder
    function filterCategories(categories) {
        if (!categories || categories.length === 0)
            return [root.placeholder]

        const additional = categories.filter(c => c in root.appCategories.additional)
        if (additional.length > 0) return additional

        const reserved = categories.filter(c => c in root.appCategories.reserved)
        if (reserved.length > 0) return reserved

        const main = categories.filter(c => c in root.appCategories.main)
        if (main.length > 0) return main

        return [root.placeholder]
    }

    function iconsForCategories(categories) {
        if (!categories || categories.length === 0)
            return [root.placeholder]

        return categories.map(cat =>
            root.appCategories.main[cat] ??
            root.appCategories.additional[cat] ??
            root.appCategories.reserved[cat] ??
            root.placeholder
        )
    }

    function aggregateCategoriesToIcon(categories) {
        if (!categories || categories.length === 0)
            return root.placeholder

        const freq = categories.reduce((acc, cat) => {
            const parent = root.appCategoriesParents[cat] ?? "Utility"
            acc[parent] = (acc[parent] ?? 0) + 1
            return acc
        }, {})

        const maxCat = Object.keys(freq).reduce((best, cat) =>
            freq[cat] > freq[best] ? cat : best
        )

        return root.appCategories.main[maxCat] ?? root.placeholder
    }

    function firstIconForCategories(categories) {
        if (!categories || categories.length === 0)
            return root.placeholder

        // additional
        for (const cat of categories) {
            if (cat in root.appCategories.additional)
                return root.appCategories.additional[cat]
        }

        // main
        for (const cat of categories) {
            if (cat in root.appCategories.main)
                return root.appCategories.main[cat]
        }

        // reserved
        for (const cat of categories) {
            if (cat in root.appCategories.reserved)
                return root.appCategories.reserved[cat]
        }

        // placeholder
        return root.placeholder
    }
}
