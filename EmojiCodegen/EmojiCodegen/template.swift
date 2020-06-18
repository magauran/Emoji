extension Emoji {
{% for emoji in emojiList %}

    @available(iOS {{ emoji.iOSVersion }}, *)
    /// {{ emoji.emoji }}
    public static let {{ emoji.name }} = Emoji("{{ emoji.emoji }}")
{% endfor %}
}
