\version "2.22.1"

<<
  \new Staff { 
    \clef "treble" \key aes \major \time 4/4 
	r2 r4 c' d e f 
  }   

  \new DrumStaff {
	\time 4/4
    r2 r4 sn
  }

  \new Staff { 
    
    \clef "bass" \key aes \major \time 4/4 
	r4 a,
  }
>>

