# Group B: Healthcare Clinic

## Business Context

You work for "WellCare Medical Centre" - a multi-specialty clinic with 15 doctors, 5 locations, serving 25,000 patients annually.

## Current Data Challenges

- Doctors can't see patient history from other locations
- Appointment scheduling double-books specialists
- Insurance claims are manually processed and error-prone
- Patient care coordination between specialists is poor
- Compliance reporting takes weeks to compile

## Your Data Sources

### Patient Management System

- **patients**: patient_id, name, DOB, NHS_number, address, GP_practice
- **appointments**: appointment_id, patient_id, doctor_id, datetime, location, status
- **consultations**: consultation_id, appointment_id, diagnosis_codes, treatment_notes

### Clinical Records (separate system)

- **prescriptions**: prescription_id, patient_id, medication, dosage, prescribed_date
- **test_results**: test_id, patient_id, test_type, results, lab_date
- **referrals**: referral_id, patient_id, from_doctor, to_specialist, reason

### External Systems

- **NHS patient registry**: demographics, GP details
- **Insurance system**: coverage details, claim status
- **Pharmacy network**: prescription fulfillment

## Business Questions to Answer

- Which patients are overdue for follow-ups? (Gold layer)
- Doctor utilisation and patient flow optimisation (Gold layer)
- Real-time appointment availability (Silver layer)
- Compliance reporting for NHS contracts (Gold layer)
- Patient care pathway tracking (Gold layer)

### Compliance Considerations

- GDPR patient privacy requirements
- NHS data sharing protocols
- Clinical governance standards

---

> Use the worksheet to design Bronze → Silver → Gold data layers for WellCare Medical Centre.

## Question worksheet

```none
BRONZE Layer (Raw)

- What data arrives? (format, frequency, quality)
- Who owns this data?
- Any compliance/privacy concerns?

SILVER Layer (Cleaned)

- What cleaning rules apply?
- How do you handle quality issues?
- What validation checks are needed?

GOLD Layer (Business Ready)

- What business questions does this answer?
- Who are your end users?
- What aggregations/metrics do you create?
```

---

## Report back

- Describe your scenario
- Present your medallion design
- Class questions/feedback
