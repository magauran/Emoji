extension Emoji {
{% for emoji in emojiList %}
    /// {{ emoji.emoji }}
    @available(iOS {{ emoji.iOSVersion }}, *)
    public static let {{ emoji.name }} = Emoji("{{ emoji.emoji }}")

{% endfor %}
}
