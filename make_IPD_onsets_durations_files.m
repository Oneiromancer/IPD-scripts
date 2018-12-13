%Build mat files of 
%IPD onsets 
%1. choice onsets 2. Outcome Onsets. 

%use: ctrl-f for subject number, and or SR/SR. 

%SR PRO
Subject = 'Sub103_SR';
names={'CoopChoice', 'DefectChoice', 'CC_Outcome', 'CD_Outcome', 'DC_Outcome', 'DD_outcome'};
Durations = 6; %all events are 6s duration. 
mkdir('E:\AdamData\SANS Data\Sub103\SR\Behavior\onsets_durations\IPD');
cd('E:\AdamData\SANS Data\Sub103\SR\Behavior\onsets_durations\IPD')

CoopChoice = [108
];

DefectChoice = [3
24
45
66
87
129
150
171
192
213
234
255
276
297
318
];

CC_outcome = [118
]

DD_Outcome = [55
97
160
223
286
]

CD_Outcome  = ['NaN'];
DC_Outcome = [13
34
76
139
181
202
244
265
307
328
];

SR_PRO_onsets = {CoopChoice DefectChoice CC_outcome DD_Outcome CD_Outcome DC_Outcome};

%SR ANTI 
Subject = 'Sub103_SR';
names={'CoopChoice', 'DefectChoice', 'CC_Outcome', 'CD_Outcome', 'DC_Outcome', 'DD_outcome'};
Durations = 6; %all events are 6s duration. 

CoopChoice = [3
];

DefectChoice = [24
45
66
87
108
129
150
171
192
213
234
255
276
297
318
];

CC_outcome = ['NaN']

DD_Outcome = [55
97
139
202
223
244
265
286
307
328
]

CD_Outcome  = [13
];
DC_Outcome = [34
76
118
160
181
];


SR_ANTI_onsets = {CoopChoice DefectChoice CC_outcome DD_Outcome CD_Outcome DC_Outcome};

save('SR_IPD_onsets_durations_file', 'SR_PRO_onsets', 'SR_ANTI_onsets', 'Durations')




