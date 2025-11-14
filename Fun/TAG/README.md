# Text Adventure Generator T.A.G. 🐉

Welcome to T.A.G. the Text Adventure Generator. T.A.G. is a single, powerful prompt designed to turn any advanced Large Language Model (LLM) into a dynamic, next-generation text adventure game master. Forget predefined paths and a limited set of commands. This prompt creates a living, breathing world that reacts to your every decision, description, and crazy idea. Your story is not pre-written; it's procedurally generated in real-time, just for you.

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

---

## What Makes This "Next-Gen"?

This isn't your parents' Zork or 80 Days. By leveraging the power of a modern LLM's, this prompt creates an experience with:

* **Unbound Freedom:** The only limit is your own imagination.
* **Dynamic World:** The world is procedurally generated as you explore it. No two playthroughs will ever be the same.
* **Immersive Narration:** Experience procedurally generated descriptions that bring your unique world to life with stunning detail.
* **Intelligent NPCs:** Interact with characters who have memories, motivations (sometimes), and respond realistically to your dialogue and actions.
* **Persistent State:** The game master will track your inventory, location, and key story events, providing a continuous and coherent narrative. Type `~` anytime during the game to switch to console mode, where you can interact with the game mechanics.
* **Customizable:** Add your own rules or gamelogic to your own wishes:
  * you want the AI to generate a picture of every new location or item? just add a rule for it in the `<GAMELOOP>`.
  * you want to have a gameover state? Add health as a parameter to the `<MODEL>` JSON
  * you want to have a specific event mentioned or charachter? Add a description to the 2nd question of the initilization about the key lore.

---

## How to Play

Getting started on your unique adventure takes less than 30 seconds.

1. **Copy the Prompt:** Open the [prompt.md](prompt.md) file in this repository and copy the entire text of the prompt.
2. **Choose Your LLM:** Go to your favorite AI chat interface (like Gemini, ChatGPT, Claude, etc.). **It is highly recommended to start a brand new conversation** to ensure the AI has no conflicting context.
3. **Paste and Go:** Paste the prompt into the chat box and send it. The AI will take on the role of the Game Master and present you with the start of your adventure.
That's it! Just follow the instructions and start your story.

---

## Example Snippet

Here's a taste of what an interaction might look like:

You lean forward, your fingers hovering over the ancient, dusty keyboard. The solution feels close, a single word hanging in the air.

```text
ENTER PASSWORD >_
```

What do you type?

You can also:

```text
A) Clear your thoughts
B) Step away from the console
```

---

## Tips for the Best Experience

* **Be Descriptive:** The more detail you provide in your actions, the more richly the AI will build the world around you.
* **Embrace Creativity:** Try unconventional solutions! The LLM is designed to improvise.
* **Talk to Everyone:** Engage NPCs in conversation. You never know what you might learn.

---

## Contributing

Have an idea to make the prompt even better? Your contributions are welcome!

1. **Fork** the repository.
2. Make your changes to the [prompt.md](prompt.md) file in a new branch.
3. Submit a **Pull Request** with a clear description of your improvement.

You can also open an **Issue** to suggest a feature, report a "bug" in the prompt's logic, or share an amazing gameplay story!
