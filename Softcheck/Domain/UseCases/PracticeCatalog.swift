import Foundation

/// Local, static lookup table of micro-practices matched to emotion shades.
/// No network calls — the whole library ships inside the app.
enum PracticeCatalog {
    static let all: [Practice] = [
        Practice(
            id: "breathing.478",
            category: .breathing,
            name: "4-7-8 breathing",
            description: "Inhale for 4 counts, hold for 7, exhale for 8. Repeat four times — your body will begin to slow on its own.",
            matchedShadeIDs: ["anxious.nervous", "anxious.uneasy", "overwhelmed.pressured", "angry.irritated"],
            duration: 120
        ),
        Practice(
            id: "grounding.54321",
            category: .grounding,
            name: "5 senses",
            description: "Name 5 things you see, 4 you hear, 3 you feel on your skin. It gently brings you back to now.",
            matchedShadeIDs: ["anxious.racing", "overwhelmed.foggy", "overwhelmed.stretched", "lonely.disconnected"],
            duration: 180
        ),
        Practice(
            id: "journaling.onethought",
            category: .journaling,
            name: "One thought on paper",
            description: "Write one sentence about what is happening inside right now. No editing, no goal — just let it out.",
            matchedShadeIDs: ["sad.heavy", "sad.disappointed", "angry.resentful", "overwhelmed.foggy"],
            duration: 300
        ),
        Practice(
            id: "movement.shoulderRelease",
            category: .movement,
            name: "Neck and shoulder stretch",
            description: "Slowly tip your ear toward your shoulder, hold, then switch sides. Soften what has been holding tension.",
            matchedShadeIDs: ["tired.overloaded", "overwhelmed.stretched", "angry.irritated"],
            duration: 90
        ),
        Practice(
            id: "movement.shortWalk",
            category: .movement,
            name: "A short walk",
            description: "Five minutes outside, or just to a window and back. A change of place can settle your thoughts.",
            matchedShadeIDs: ["sad.low", "tired.drained", "lonely.longing"],
            duration: 300
        ),
        Practice(
            id: "senses.water",
            category: .senses,
            name: "A glass of water and a pause",
            description: "Pour some water, drink it slowly, in quiet. A simple act that brings care for yourself back into the body.",
            matchedShadeIDs: ["tired.drained", "anxious.nervous", "calm.relieved"],
            duration: 60
        ),
        Practice(
            id: "journaling.gratitude",
            category: .journaling,
            name: "Three gratitude notes",
            description: "Write three small things you feel grateful for right now. Nothing grand — ordinary, warm ones.",
            matchedShadeIDs: ["joyful.grateful", "calm.peaceful", "calm.clear"],
            duration: 180
        ),
        Practice(
            id: "connection.kindWords",
            category: .connection,
            name: "Kind words to yourself",
            description: "Say out loud or quietly what you would say to a close friend in your place.",
            matchedShadeIDs: ["sad.disappointed", "angry.hurt", "lonely.unseen"],
            duration: 120
        ),
        Practice(
            id: "senses.music",
            category: .senses,
            name: "A favorite song",
            description: "Play one song that truly means something to you, and simply listen all the way through.",
            matchedShadeIDs: ["joyful.excited", "joyful.light", "tired.sleepy"],
            duration: 180
        ),
        Practice(
            id: "grounding.bodyScan",
            category: .grounding,
            name: "Body scan",
            description: "Move your attention from the crown of your head to your feet, noticing where there is tension, without trying to fix it.",
            matchedShadeIDs: ["overwhelmed.pressured", "tired.overloaded", "anxious.racing"],
            duration: 240
        ),
        Practice(
            id: "connection.reachOut",
            category: .connection,
            name: "Message someone close",
            description: "A short note to someone who feels warm to be around. It does not have to be about feelings — just contact.",
            matchedShadeIDs: ["lonely.disconnected", "lonely.longing", "sad.low"],
            duration: 180
        ),
        Practice(
            id: "rest.permission",
            category: .rest,
            name: "Permission to rest",
            description: "Give yourself five minutes of doing nothing. No guilt, no productivity timer.",
            matchedShadeIDs: ["tired.drained", "tired.sleepy", "overwhelmed.stretched"],
            duration: 300
        ),
        Practice(
            id: "movement.dance",
            category: .movement,
            name: "Dance to one song",
            description: "Put on music and move however your body wants — no audience, no correct technique.",
            matchedShadeIDs: ["angry.resentful", "joyful.excited", "angry.irritated"],
            duration: 180
        ),
        Practice(
            id: "senses.coolWater",
            category: .senses,
            name: "Cool water on your wrists",
            description: "Hold your wrists under cool water for about thirty seconds. A gentle body cue that it is okay to settle.",
            matchedShadeIDs: ["angry.hurt", "anxious.uneasy", "overwhelmed.pressured"],
            duration: 60
        ),
        Practice(
            id: "journaling.needPrompt",
            category: .journaling,
            name: "What do I need right now?",
            description: "Finish the sentence: \"Right now it would feel easier if...\". Write the first thing that comes.",
            matchedShadeIDs: ["calm.clear", "joyful.grateful", "sad.heavy", "lonely.unseen"],
            duration: 180
        ),
        Practice(
            id: "breathing.box",
            category: .breathing,
            name: "Box breathing",
            description: "Inhale 4, hold 4, exhale 4, hold 4. Repeat a few rounds until the edges soften.",
            matchedShadeIDs: ["anxious.nervous", "overwhelmed.pressured", "angry.irritated"],
            duration: 120
        ),
        Practice(
            id: "breathing.sigh",
            category: .breathing,
            name: "Physiological sigh",
            description: "Take a double inhale through the nose, then a long slow exhale through the mouth. Repeat twice.",
            matchedShadeIDs: ["anxious.racing", "anxious.uneasy", "overwhelmed.foggy"],
            duration: 60
        ),
        Practice(
            id: "breathing.handOnHeart",
            category: .breathing,
            name: "Hand on heart breaths",
            description: "Place a hand on your chest and feel three slow breaths rise and fall under your palm.",
            matchedShadeIDs: ["sad.heavy", "lonely.unseen", "tired.drained"],
            duration: 90
        ),
        Practice(
            id: "breathing.countDown",
            category: .breathing,
            name: "Countdown exhales",
            description: "Inhale gently, then exhale while counting down from five to one. Repeat.",
            matchedShadeIDs: ["anxious.nervous", "overwhelmed.stretched", "angry.hurt"],
            duration: 120
        ),
        Practice(
            id: "breathing.softBelly",
            category: .breathing,
            name: "Soft belly breathing",
            description: "Let your belly expand on the inhale and soften on the exhale — no forcing.",
            matchedShadeIDs: ["calm.peaceful", "tired.overloaded", "anxious.uneasy"],
            duration: 150
        ),
        Practice(
            id: "grounding.feetFloor",
            category: .grounding,
            name: "Feet on the floor",
            description: "Press both feet into the floor and notice the contact points for one full minute.",
            matchedShadeIDs: ["anxious.racing", "overwhelmed.foggy", "lonely.disconnected"],
            duration: 60
        ),
        Practice(
            id: "grounding.nameColors",
            category: .grounding,
            name: "Name three colors",
            description: "Look around and quietly name three colors you can see right now.",
            matchedShadeIDs: ["anxious.uneasy", "overwhelmed.pressured", "tired.sleepy"],
            duration: 45
        ),
        Practice(
            id: "grounding.temperature",
            category: .grounding,
            name: "Notice temperature",
            description: "Where does your body feel warm, cool, or neutral? Just notice.",
            matchedShadeIDs: ["overwhelmed.foggy", "sad.low", "calm.relieved"],
            duration: 90
        ),
        Practice(
            id: "grounding.objectHold",
            category: .grounding,
            name: "Hold a familiar object",
            description: "Hold something ordinary — a mug, a stone, a key — and describe its texture to yourself.",
            matchedShadeIDs: ["anxious.nervous", "lonely.longing", "overwhelmed.stretched"],
            duration: 120
        ),
        Practice(
            id: "grounding.windowGaze",
            category: .grounding,
            name: "Window gaze",
            description: "Look out a window and track one slow moving thing: a cloud, a leaf, a person walking.",
            matchedShadeIDs: ["tired.overloaded", "anxious.racing", "calm.clear"],
            duration: 120
        ),
        Practice(
            id: "grounding.orientRoom",
            category: .grounding,
            name: "Orient to the room",
            description: "Name the year, the place you are, and one safe fact about this room.",
            matchedShadeIDs: ["anxious.racing", "overwhelmed.foggy", "angry.hurt"],
            duration: 60
        ),
        Practice(
            id: "journaling.halfPage",
            category: .journaling,
            name: "Half-page dump",
            description: "Write without stopping for half a page. Spelling and sense do not matter.",
            matchedShadeIDs: ["sad.heavy", "angry.resentful", "overwhelmed.stretched"],
            duration: 300
        ),
        Practice(
            id: "journaling.letterUnsent",
            category: .journaling,
            name: "Unsent letter",
            description: "Write three sentences you wish you could say, then leave them on the page.",
            matchedShadeIDs: ["angry.hurt", "lonely.unseen", "sad.disappointed"],
            duration: 240
        ),
        Practice(
            id: "journaling.weatherReport",
            category: .journaling,
            name: "Inner weather report",
            description: "Describe today's inner weather in one sentence: cloudy, windy, clearing...",
            matchedShadeIDs: ["calm.clear", "joyful.light", "sad.low"],
            duration: 120
        ),
        Practice(
            id: "journaling.smallWin",
            category: .journaling,
            name: "One small win",
            description: "Write one thing that went okay today, even if it was tiny.",
            matchedShadeIDs: ["joyful.grateful", "tired.drained", "lonely.disconnected"],
            duration: 120
        ),
        Practice(
            id: "journaling.boundaryNote",
            category: .journaling,
            name: "Gentle boundary note",
            description: "Finish: \"I can say no to ___ and still be kind.\"",
            matchedShadeIDs: ["overwhelmed.pressured", "angry.irritated", "tired.overloaded"],
            duration: 180
        ),
        Practice(
            id: "journaling.futureKind",
            category: .journaling,
            name: "Note to future you",
            description: "Write two kind sentences for yourself later tonight.",
            matchedShadeIDs: ["sad.disappointed", "anxious.uneasy", "lonely.longing"],
            duration: 180
        ),
        Practice(
            id: "movement.shakeOut",
            category: .movement,
            name: "Shake it out",
            description: "Stand and gently shake your hands, arms, and shoulders for thirty seconds.",
            matchedShadeIDs: ["angry.irritated", "anxious.nervous", "overwhelmed.pressured"],
            duration: 45
        ),
        Practice(
            id: "movement.wallPush",
            category: .movement,
            name: "Wall push",
            description: "Press both palms into a wall for ten slow breaths, then release.",
            matchedShadeIDs: ["angry.resentful", "tired.overloaded", "anxious.racing"],
            duration: 90
        ),
        Practice(
            id: "movement.slowSquats",
            category: .movement,
            name: "Three slow squats",
            description: "Move down and up three times with soft knees — feel your legs wake up.",
            matchedShadeIDs: ["tired.sleepy", "sad.low", "calm.relieved"],
            duration: 90
        ),
        Practice(
            id: "movement.armCircles",
            category: .movement,
            name: "Soft arm circles",
            description: "Make small arm circles forward, then back, without forcing range.",
            matchedShadeIDs: ["tired.drained", "overwhelmed.stretched", "joyful.excited"],
            duration: 60
        ),
        Practice(
            id: "movement.stepOutside",
            category: .movement,
            name: "Step outside door",
            description: "Open a door, step out for sixty seconds of air, then decide what next.",
            matchedShadeIDs: ["lonely.disconnected", "sad.heavy", "tired.sleepy"],
            duration: 90
        ),
        Practice(
            id: "movement.stretchFloor",
            category: .movement,
            name: "Floor child's pose",
            description: "Kneel, fold forward if comfortable, and rest for a few breaths.",
            matchedShadeIDs: ["tired.overloaded", "overwhelmed.foggy", "sad.heavy"],
            duration: 120
        ),
        Practice(
            id: "connection.selfHug",
            category: .connection,
            name: "Self hug",
            description: "Wrap your arms around yourself and squeeze gently for three breaths.",
            matchedShadeIDs: ["lonely.unseen", "sad.heavy", "angry.hurt"],
            duration: 60
        ),
        Practice(
            id: "connection.photoSomeone",
            category: .connection,
            name: "Look at a warm photo",
            description: "Open a photo of someone or somewhere that feels warm, and sit with it briefly.",
            matchedShadeIDs: ["lonely.longing", "joyful.grateful", "sad.low"],
            duration: 90
        ),
        Practice(
            id: "connection.voiceNote",
            category: .connection,
            name: "Voice note to a friend",
            description: "Send a short voice note that is not about problems — just hello.",
            matchedShadeIDs: ["lonely.disconnected", "joyful.light", "calm.peaceful"],
            duration: 120
        ),
        Practice(
            id: "connection.petOrPlant",
            category: .connection,
            name: "Tend a living thing",
            description: "Water a plant or gently pet an animal if you have one nearby.",
            matchedShadeIDs: ["lonely.longing", "calm.peaceful", "tired.drained"],
            duration: 120
        ),
        Practice(
            id: "connection.complimentMirror",
            category: .connection,
            name: "One honest compliment",
            description: "Look in a mirror and offer one honest, non-appearance compliment.",
            matchedShadeIDs: ["lonely.unseen", "sad.disappointed", "joyful.grateful"],
            duration: 60
        ),
        Practice(
            id: "rest.eyesClosed",
            category: .rest,
            name: "Eyes-closed minute",
            description: "Close your eyes for sixty seconds. Let the to-do list wait outside the room.",
            matchedShadeIDs: ["tired.sleepy", "overwhelmed.stretched", "anxious.uneasy"],
            duration: 60
        ),
        Practice(
            id: "rest.lieDown",
            category: .rest,
            name: "Lie down without sleep goal",
            description: "Lie down for three minutes with no pressure to sleep.",
            matchedShadeIDs: ["tired.drained", "tired.overloaded", "sad.low"],
            duration: 180
        ),
        Practice(
            id: "rest.dimLights",
            category: .rest,
            name: "Dim the lights",
            description: "Lower the lights or cover a bright screen. Let the room get softer.",
            matchedShadeIDs: ["tired.sleepy", "overwhelmed.pressured", "anxious.racing"],
            duration: 60
        ),
        Practice(
            id: "rest.blanketCocoon",
            category: .rest,
            name: "Blanket cocoon",
            description: "Wrap yourself in a blanket and notice warmth for a few breaths.",
            matchedShadeIDs: ["lonely.disconnected", "sad.heavy", "tired.drained"],
            duration: 120
        ),
        Practice(
            id: "rest.noTaskCorner",
            category: .rest,
            name: "No-task corner",
            description: "Sit somewhere with zero tasks for four minutes. That is the whole practice.",
            matchedShadeIDs: ["overwhelmed.stretched", "tired.overloaded", "calm.relieved"],
            duration: 240
        ),
        Practice(
            id: "rest.earlyBedPrep",
            category: .rest,
            name: "Early wind-down cue",
            description: "Do one bedtime cue now: wash face, set water, or lay out soft clothes.",
            matchedShadeIDs: ["tired.sleepy", "anxious.nervous", "overwhelmed.foggy"],
            duration: 180
        ),
        Practice(
            id: "senses.scent",
            category: .senses,
            name: "Notice a scent",
            description: "Smell tea, soap, or outdoor air and describe it in three words.",
            matchedShadeIDs: ["calm.peaceful", "joyful.light", "anxious.uneasy"],
            duration: 60
        ),
        Practice(
            id: "senses.texture",
            category: .senses,
            name: "Texture check",
            description: "Touch fabric, wood, or paper and notice rough, smooth, warm, cool.",
            matchedShadeIDs: ["anxious.racing", "overwhelmed.foggy", "tired.sleepy"],
            duration: 60
        ),
        Practice(
            id: "senses.warmDrink",
            category: .senses,
            name: "Warm drink slowly",
            description: "Sip something warm and feel it travel. No scrolling while you drink.",
            matchedShadeIDs: ["tired.drained", "sad.low", "calm.relieved"],
            duration: 180
        ),
        Practice(
            id: "senses.soundscape",
            category: .senses,
            name: "Listen for layers",
            description: "Close your eyes and count three layers of sound around you.",
            matchedShadeIDs: ["anxious.nervous", "overwhelmed.pressured", "calm.clear"],
            duration: 90
        ),
        Practice(
            id: "senses.sunlight",
            category: .senses,
            name: "Catch a bit of light",
            description: "Stand where there is daylight on your face or hands for one minute.",
            matchedShadeIDs: ["sad.low", "tired.sleepy", "joyful.excited"],
            duration: 60
        ),
        Practice(
            id: "senses.flavorPause",
            category: .senses,
            name: "One mindful bite",
            description: "Take one bite of food and notice flavor before the next.",
            matchedShadeIDs: ["joyful.grateful", "calm.peaceful", "tired.overloaded"],
            duration: 60
        ),
        Practice(
            id: "breathing.hum",
            category: .breathing,
            name: "Humming exhale",
            description: "Inhale softly, then hum on the exhale for a few rounds.",
            matchedShadeIDs: ["anxious.uneasy", "angry.hurt", "lonely.disconnected"],
            duration: 90
        ),
        Practice(
            id: "movement.neckRolls",
            category: .movement,
            name: "Gentle neck rolls",
            description: "Slow half-circles with your neck — never force a full spin.",
            matchedShadeIDs: ["tired.overloaded", "angry.irritated", "overwhelmed.stretched"],
            duration: 90
        ),
        Practice(
            id: "journaling.bodyAsk",
            category: .journaling,
            name: "Ask the body",
            description: "Write: \"Body, what would feel 5% kinder right now?\" Answer once.",
            matchedShadeIDs: ["tired.drained", "sad.heavy", "overwhelmed.foggy"],
            duration: 150
        ),
        Practice(
            id: "connection.thankYouText",
            category: .connection,
            name: "Thank-you text",
            description: "Send a short thank-you to someone for something specific and small.",
            matchedShadeIDs: ["joyful.grateful", "lonely.longing", "calm.clear"],
            duration: 120
        ),
        Practice(
            id: "grounding.handPress",
            category: .grounding,
            name: "Palm press",
            description: "Press your palms together firmly for ten seconds, then release and notice.",
            matchedShadeIDs: ["anxious.nervous", "angry.irritated", "overwhelmed.pressured"],
            duration: 45
        ),
        Practice(
            id: "rest.permissionNap",
            category: .rest,
            name: "Permission nap",
            description: "Set a ten-minute timer and rest without calling it lazy.",
            matchedShadeIDs: ["tired.sleepy", "tired.drained", "sad.low"],
            duration: 600
        ),
        Practice(
            id: "senses.barefoot",
            category: .senses,
            name: "Barefoot moment",
            description: "If safe, stand barefoot and notice the floor under you.",
            matchedShadeIDs: ["anxious.racing", "calm.peaceful", "joyful.light"],
            duration: 60
        ),
    ]

    /// Generic fallback when a shade has no direct match — never leaves the
    /// user without a moment of outcome.
    static let fallback = Practice(
        id: "rest.fallback",
        category: .rest,
        name: "One calm breath",
        description: "Take one slow inhale and exhale. That is enough — you already did the main thing by pausing and noticing yourself.",
        matchedShadeIDs: [],
        duration: 30
    )

    static func match(shadeID: String) -> Practice {
        let candidates = all.filter { $0.matchedShadeIDs.contains(shadeID) }
        return candidates.randomElement() ?? fallback
    }

    static func practice(id: String) -> Practice? {
        all.first { $0.id == id } ?? (id == fallback.id ? fallback : nil)
    }
}
