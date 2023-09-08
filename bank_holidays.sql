DROP TABLE IF EXISTS swe_bank_holidays;

CREATE TABLE swe_bank_holidays(
    holiday_date date unique NOT NULL,
    swe_hol_flag INT NOT NULL
);

INSERT or IGNORE INTO swe_bank_holidays(holiday_date, swe_hol_flag)
VALUES ('2022-01-01', 'Y'),
        ('2022-01-06', 'Y'),
        ('2022-04-15', 'Y'),
        ('2022-04-17', 'Y'),
        ('2022-04-18', 'Y'),
        ('2022-05-01', 'Y'),
        ('2022-05-26', 'Y'),
        ('2022-06-05', 'Y'),
        ('2022-06-06', 'Y'),
        ('2022-06-25', 'Y'),
        ('2022-11-05', 'Y'),
        ('2022-12-25', 'Y'),
        ('2022-12-26', 'Y'),
        ('2023-01-01', 'Y'),
        ('2023-01-06', 'Y'),
        ('2023-04-07', 'Y'),
        ('2023-04-09', 'Y'),
        ('2023-04-10', 'Y'),
        ('2023-05-01', 'Y'),
        ('2023-05-18', 'Y'),
        ('2023-05-28', 'Y'),
        ('2023-06-06', 'Y'),
        ('2023-06-24', 'Y'),
        ('2023-11-04', 'Y'),
        ('2023-12-25', 'Y'),
        ('2023-12-26', 'Y');

SELECT * FROM swe_bank_holidays;
