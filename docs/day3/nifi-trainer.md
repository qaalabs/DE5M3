# Trainer Notes - Lab 3.2 Apache NiFi

## Before the Session

- Start the NiFi container at 09:20 during the planning slot:

```bash
docker run -d -p 8443:8443 --name nifi \
  -e SINGLE_USER_CREDENTIALS_USERNAME=admin \
  -e SINGLE_USER_CREDENTIALS_PASSWORD=admin123456789 \
  apache/nifi:1.23.2
```

- NiFi takes 2-3 minutes to fully initialise after the container starts
- By 13:20 it will have been running for hours - no startup issues
- Remind learners to create their directories and CSV file before touching 
the NiFi canvas

## Common Issues

**Browser shows connection refused or blank screen**

- Container is not running - check `docker ps`
- NiFi has not finished starting - check `docker logs nifi --tail 5`

**Certificate warning in browser**

- This is expected - learners just click through it
- Tell them this is because NiFi uses a self-signed certificate by default

**Yellow warning triangle on processor**

- Normal until configured - reassure learners immediately
- It will disappear once properties are set correctly

**Pipeline starts but nothing appears in output**

- GetFile has already consumed the file and deleted it (if Keep Source 
File was not set to true)
- Fix: put a new file in the input directory and check Keep Source File 
is set to true
- Check the connection queues - are there numbers showing? If so the file 
is queued but not moving

**Processor stays red after starting**

- Usually means a required property is missing or a directory does not exist
- Right-click the processor and select View Status History for details
- Most common cause: output directory does not exist - run mkdir again

**LogAttribute relationships not terminated**

- Pipeline will not start if unconnected relationships are not terminated
- Right-click LogAttribute → Configure → Relationships tab → tick 
Automatically Terminate for all unconnected relationships
- Do the same for PutFile

## Step 9 - Export Flow Definition

- The downloaded file name will be a long UUID - that is normal
- If learners cannot find the downloaded file check the browser downloads folder
- The JSON will be more complex than the example shown - that is fine, point out the processor names and properties sections so they can 
orientate themselves
- This step takes 5 minutes maximum - do not let it overrun into break time

---

## Timing Guide

| Time  | Activity                                             |
|-------|------------------------------------------------------|
| 13:35 | ETL Tools Landscape intro - frame the tool landscape |
| 13:45 | Learners start lab - Step 1 directory and file setup |
| 13:50 | Learners building processors on canvas               |
| 14:10 | Most learners should have pipeline running           |
| 14:15 | L1/L2 on reflection questions, L3/L4 on extensions   |
| 14:20 | Begin debrief discussion                             |

---

## Facilitation Tips

**Do a quick demo first** 

- Spend 3 minutes showing the canvas, adding one processor, explaining what it is. 
- Learners who have never seen NiFi will be disoriented without this anchor.

**Walk the room during Step 5**

- (connecting processors) ~ this is where most people get stuck. 
- The hover-to-get-arrow interaction is not intuitive first time.

**Point out the connection queue numbers**

- When the pipeline is running ~ this is the moment that lands for most learners.
- Watching a number tick up and then down as data flows through is more powerful than any explanation.

**Do not troubleshoot individually for more than 2 minutes**

- if a learner is stuck, pair them with someone who has it working rather than spending session time debugging.

## Debrief Discussion (14:20 - 14:30)

Run this as a whole group discussion, not breakouts. Ten minutes only.

**Opening question - let them respond freely:**

*"You have now built a pipeline in Python, in Microsoft Fabric, and in 
Apache NiFi. What is different about the NiFi experience?"*

**Expected responses to draw out:**

- Visual like Fabric but runs locally, no cloud needed
- Can see data moving in real time - Fabric does not show that
- No code written at all
- More granular than Fabric - every step is explicit

**Follow-up if the room is quiet:**

*"NiFi is free and open source. Fabric costs money and is tied to 
Microsoft. When would that matter to a business?"*

**Expected responses:**

- Cost - NiFi has no licence fee
- Vendor lock-in - NiFi runs anywhere, Fabric requires Azure
- Control - NiFi runs on your own infrastructure, data never leaves
- Support - Fabric has Microsoft support, NiFi relies on community

**Close with this:**

*"This is what K20 means in your KSBs - types and uses of data engineering 
tools. You now have direct experience of three fundamentally different 
approaches to the same problem. That is what you talk about in your 
professional discussion."*

---

## Extension Tasks - What to Expect

**Provenance view**

- Learners will find this genuinely interesting.
- It shows every file that has passed through NiFi with a complete audit trail.
- Point out that this is data lineage - K11 in their KSBs. 
- You do not need to teach it, just name it when they find it.

**FetchHTTP question**

- good L3/L4 discussion starter.

*Expected answer:*

FetchHTTP makes HTTP requests, so it could replace the requests.get() calls 
from the Day 1 API lab. The insight is that NiFi can do what Python did 
but without writing code.

