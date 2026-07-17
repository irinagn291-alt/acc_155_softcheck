import Foundation

/// A nuanced shade of a petal's broader emotion family — what the user
/// actually picks after tapping a petal. Framed as "what do I feel", never
/// scored as good or bad.
struct EmotionShade: Identifiable, Hashable, Sendable {
    let id: String
    let petal: EmotionPetal
    let label: String
    /// Short, supportive framing — never judgmental or clinical.
    let supportiveCopy: String
}

extension EmotionShade {
    /// The full static catalog of shades, three per petal.
    static let all: [EmotionShade] = [
        EmotionShade(
            id: "joyful.grateful",
            petal: .joyful,
            label: "Gratitude",
            supportiveCopy: "Something small feels worth thanking — that counts."
        ),
        EmotionShade(
            id: "joyful.excited",
            petal: .joyful,
            label: "Excitement",
            supportiveCopy: "Energy is rising. You can enjoy it without rushing ahead."
        ),
        EmotionShade(
            id: "joyful.light",
            petal: .joyful,
            label: "Lightness",
            supportiveCopy: "A little ease is here. Let it stay as long as it wants."
        ),

        EmotionShade(
            id: "calm.peaceful",
            petal: .calm,
            label: "Peacefulness",
            supportiveCopy: "Quiet is enough. Nothing needs to be fixed right now."
        ),
        EmotionShade(
            id: "calm.relieved",
            petal: .calm,
            label: "Relief",
            supportiveCopy: "Something eased. Your body may want a slower breath."
        ),
        EmotionShade(
            id: "calm.clear",
            petal: .calm,
            label: "Clarity",
            supportiveCopy: "Things feel a bit clearer — you can move one step at a time."
        ),

        EmotionShade(
            id: "sad.heavy",
            petal: .sad,
            label: "Heaviness",
            supportiveCopy: "Heavy feelings are allowed. Soften the pace around them."
        ),
        EmotionShade(
            id: "sad.disappointed",
            petal: .sad,
            label: "Disappointment",
            supportiveCopy: "Something didn't land as hoped. That ache deserves kindness."
        ),
        EmotionShade(
            id: "sad.low",
            petal: .sad,
            label: "Feeling low",
            supportiveCopy: "Low energy is information, not failure. Small care helps."
        ),

        EmotionShade(
            id: "anxious.nervous",
            petal: .anxious,
            label: "Nervousness",
            supportiveCopy: "Nerves mean you care. You can steady one breath at a time."
        ),
        EmotionShade(
            id: "anxious.racing",
            petal: .anxious,
            label: "Racing thoughts",
            supportiveCopy: "Thoughts are moving fast. Anchoring in the senses can help."
        ),
        EmotionShade(
            id: "anxious.uneasy",
            petal: .anxious,
            label: "Unease",
            supportiveCopy: "Unease can sit beside you without needing a verdict."
        ),

        EmotionShade(
            id: "angry.irritated",
            petal: .angry,
            label: "Irritation",
            supportiveCopy: "Friction is present. Your body may want space or movement."
        ),
        EmotionShade(
            id: "angry.resentful",
            petal: .angry,
            label: "Resentment",
            supportiveCopy: "Something still feels unfair. Naming it is already care."
        ),
        EmotionShade(
            id: "angry.hurt",
            petal: .angry,
            label: "Hurt",
            supportiveCopy: "Hurt often hides under heat. Gentleness is allowed here."
        ),

        EmotionShade(
            id: "tired.drained",
            petal: .tired,
            label: "Drained",
            supportiveCopy: "Your reserves are low. Rest is a valid next step."
        ),
        EmotionShade(
            id: "tired.sleepy",
            petal: .tired,
            label: "Sleepiness",
            supportiveCopy: "Sleepiness is a cue, not a flaw. Soften the demands a little."
        ),
        EmotionShade(
            id: "tired.overloaded",
            petal: .tired,
            label: "Overloaded",
            supportiveCopy: "Too much at once. One smaller piece is enough for now."
        ),

        EmotionShade(
            id: "lonely.disconnected",
            petal: .lonely,
            label: "Disconnected",
            supportiveCopy: "Distance can feel loud. A tiny contact may help — or quiet."
        ),
        EmotionShade(
            id: "lonely.longing",
            petal: .lonely,
            label: "Longing for closeness",
            supportiveCopy: "Wanting closeness is human. You don't have to earn it."
        ),
        EmotionShade(
            id: "lonely.unseen",
            petal: .lonely,
            label: "Feeling unseen",
            supportiveCopy: "Feeling unseen hurts. You still matter in this moment."
        ),

        EmotionShade(
            id: "overwhelmed.stretched",
            petal: .overwhelmed,
            label: "Stretched thin",
            supportiveCopy: "You're holding a lot. Permission to put one thing down."
        ),
        EmotionShade(
            id: "overwhelmed.foggy",
            petal: .overwhelmed,
            label: "Mental fog",
            supportiveCopy: "Fog means slow is wise. Clarity can wait."
        ),
        EmotionShade(
            id: "overwhelmed.pressured",
            petal: .overwhelmed,
            label: "Pressure",
            supportiveCopy: "Pressure is present. Unclench what you can, even a little."
        )
    ]

    static func find(id: String) -> EmotionShade? {
        all.first { $0.id == id }
    }
}
