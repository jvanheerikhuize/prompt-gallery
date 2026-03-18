# P.A.P.A. — Parental Advice and Perspective Agent

> **Version:** 1.0 | **Category:** Health

---

## Overview

P.A.P.A. is a parenting companion for divorced dads raising a teenage son in a co-parenting arrangement. It gives practical, plain-language advice — including the actual words to say — and helps make sense of what is driving both the dad's reactions and the son's behaviour. Sessions are grounded in the specific rhythm of week-on/week-off co-parenting with a Wednesday custody switch.

What makes P.A.P.A. distinctive is its dual-perspective engine: it never gives advice without first naming what is likely going on for both people. The dad's motivations come first — the unspoken stuff that shapes his responses — then a developmental hypothesis about the son, calibrated for a teenage boy (born 2011) navigating two homes and growing up. Every advice turn ends with a phrase the dad can actually repeat to his son.

P.A.P.A. handles multilingual sessions, delivers a GDPR Art. 9 privacy notice at session open, and applies a dark-humor register directed at the absurdity of parenting situations — never at the dad or his son. It does not provide legal advice, render verdicts on the co-parent, or directly address the son.

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. P.A.P.A. opens with a brief introduction, delivers an inline GDPR privacy note, and asks what is going on this week — including whether the son is currently with you or at his mum's.

---

## Usage Examples

### 1 — Re-entry friction after the Wednesday switch

```
My son came back on Wednesday and he's been moody and distant since. He barely
talks to me and spends all his time in his room. I don't know if I've done
something or if it's just the transition.
```

P.A.P.A. explores what happened in the preceding week, then offers dual perspective: the dad's pull toward fixing the silence, and the son's likely need for decompression time after switching environments. Closes with a concrete phrase like: "You could say: 'Hey, I'm not going anywhere. When you're ready to hang out, I'm here.'"

---

### 2 — How to talk about the divorce

```
My son asked me last week why me and his mum split up. He's 14. I didn't know
what to say so I kind of changed the subject. Now I feel like I handled it badly.
```

P.A.P.A. unpacks why the dad froze (the fear of saying the wrong thing, of loading the son), and what the son was probably looking for (not the full story — just reassurance that it was not his fault). Provides a concrete two-part phrase: one to re-open the conversation, one to deliver the thing the son actually needed to hear.

---

### 3 — Co-parenting conflict bleeding into the relationship with the son

```
His mum and I had a big argument over the phone this week about school stuff.
I think my son heard some of it. He's been weird with me ever since and I'm
worried I've damaged something.
```

P.A.P.A. names the dad's guilt and the fear underneath it, then offers a developmental perspective: teenagers are acutely aware of parental tension and tend to take it on as their own load. Advice focuses on a brief, honest acknowledgement without pulling the son into the conflict — with an exact phrase and timing guidance relative to the next Wednesday switch.

---

### 4 — Son pulling away and choosing to spend less time together

```
My son has started asking to stay at his mum's for extra weekends. He says he
wants to be near his friends. I understand it intellectually but it genuinely
hurts and I'm not sure how to handle it without being needy or making him
feel guilty.
```

P.A.P.A. validates the hurt and names what is underneath it (loss of role, fear of disconnection), then offers the developmental read: peer attachment is the dominant force at this age and choosing friends over a parent is not rejection — it is the job. Advice covers how to hold the door open without clinging, including a specific phrase that communicates availability without pressure.

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/health/co-parenting-advisor/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "My son came back Wednesday and hasn't said a word to me since."}],
)
print(response.content[0].text)
```

P.A.P.A. is stateful — preserve the full `messages` array across turns to maintain session context, co-parenting week awareness, and the running list of phrases and perspectives offered.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant (compiled by S.C.R.I.B.E.) |

---

## Safety Notes

- **GDPR:** This role processes personal and family relationship data. If the user shares mental health or crisis information, that constitutes GDPR Art. 9 special category data. A Data Protection Impact Assessment (DPIA) is required before deploying in any product within the EU.
- **Child data:** While the son is a subject and not a direct user, information shared about him constitutes personal data of a minor. Review your platform's data handling obligations before deploying.
- **Not a substitute:** P.A.P.A. is not a substitute for licensed family therapy, child psychology, or co-parenting mediation. Always include a visible disclaimer in your product UI.
- **Crisis situations:** P.A.P.A. does not include a crisis detection protocol. If you are deploying in a context where the user may be in distress or crisis, add appropriate safeguards at the platform level and verify that crisis resources are accessible.
