---
chapter: Refocused INEPT, Delayed Decoupling and In-Phase Spectra
author: Justin Lorieau
targets: html, tex, pdf
toc: all headings abbreviated
@CH: CH
@CH2: CH@sub{2}
@CH3: CH@sub{3}
@T1: T@sub{1}
@p90: 90@deg
@p180: 180@deg
@p90x: 90@supsub{○ && x}
@p180x: 180@supsub{○ && x}
@p90x1H: @p90x (@1H)
@p180x1H: @p180x (@1H)
@p180xX: @p180x (X)
@p180x13C: @p180x (@13C)
@CSh: @omega@sub{H}
@Jnh: J@sub{NH}
@Jch: J@sub{CH}
@CcsD: @term[color=blue]{C_{CS@Delta}}
@CjD : @term[color=blue]{C_{@Jnh @Delta}}
@ScsD: @term[color=red!80!black]{S_{CS@Delta}}
@SjD : @term[color=red!80!black]{S_{@Jnh @Delta}}
@eqbreak: \displaybreak[2] \\[0.5em]
---

@chapter
@author{}

The refocused INEPT sequence@sidenote{Burum D., Ernst R. Net polarization
  transfer via a J-ordered state for signal enhancement of low-sensitivity
  nuclei. J Magn Reson. 1980 Apr;39(1):163–168. }
(@ref{fig:ref-inept_ref-inept}) converts the anti-phase
magnetization of the INEPT sequence into in-phase magnetization, while
still benefiting from the signal enhancement of the INEPT
sequence. This approach has the advantage that the spectrum can be
decoupled to produce singlet peaks.

@section{Theory}

@marginfig[id=fig:ref-inept_ref-inept]{
  @asy[scale=1.0]{
      import pulseseq;
      PulseSeq ps = PulseSeq('1H', 'X');

      ps.add(1, Hard90());
      ps.add(1, Delay("$\Delta_1$"));
      ps.add(1, Hard180(), 2, Hard180());
      ps.add(1, Delay("$\Delta_1$"));
      ps.add(1, Hard90(Label("y")), 2, Hard90());
      ps.add(2, Delay("$\Delta_2$"));
      ps.add(1, Hard180(), 2, Hard180());
      ps.add(2, Delay("$\Delta_2$"));
      ps.add(2, Fid(2, cosmod=true));
      ps.draw();
    }
    @caption{The refocused INEPT experiment.}
  }

@marginfig[id=fig:inept_inept_v_refinept_H-dcpl]{
  @img{media/plots/ref-inept/inept_vs_ref_inept_H-dcpl.pdf}
  @caption{Comparison of @13C spectra for the INEPT sequence and
    refocused INEPT sequence with @1H decoupling during
    @13C acquisition.}
}

The @abbrv{INEPT} sequence produces
anti-phase magnetization (@i{e.g.} @termb{-2H_zC_y}) with peaks of
opposite sign, and the refocused @abbrv{INEPT} produces in-phase
magnetization (@i{e.g.} @termb{C_z}) with peaks of the same
sign. When @1H decoupling is applied to the anti-phase
magnetization of the @abbrv{INEPT} sequence, the peaks cancel each other
to produce a null spectrum. The objective of the refocused @abbrv{INEPT}
and DEPT experiments is to produce in-phase magnetization that can be
decoupled to produce singlet peaks.

@subsection{Methine, Amide and the AX Spin System}

The @i{refocused} INEPT sequence produces in-phase magnetization
that can @1H decoupled to produce high intensity singlet peaks.

In this example, we'll use a @1H spin bonded to a @13C
spin. If we use a delay, @eq{\Delta_1 = (4 @Jch)^{-1}}, the first step
of the sequence is simply an @abbrv{INEPT} sequence (@ref{fig:ref-inept_ref-inept_step1}).

@eq[env=alignat* 3]{
  @termb{H_z} & \xrightarrow{\mathmakebox[4em]{\text{INEPT}}} && @termb{-2 H_z C_y}
}

@marginfig[id=fig:ref-inept_ref-inept_step1]{
  @asy{
    import pulseseq;
    PulseSeq ps = PulseSeq('1H', '13C');

    ps.add(1, Hard90(highlight=true));
    ps.add(1, Delay("$\Delta_1$", highlight=true));
    ps.add(1, Hard180(highlight=true), 2, Hard180());
    ps.add(1, Delay("$\Delta_1$", highlight=true));
    ps.add(1, Hard90(Label("y"), highlight=true), 2, Hard90());
    ps.add(2, Delay("$\Delta_2$"));
    ps.add(1, Hard180(), 2, Hard180());
    ps.add(2, Delay("$\Delta_2$"));
    ps.add(2, Fid(2, cosmod=true));
    ps.draw();
  }
  @caption{The first step of the refocused INEPT sequence highlighted in
  red.}
}

In the second step, we'll only propagate the @Jch-coupling since the
`@term{\Delta_2-@p180x13C-\Delta_2}' pulse sequence block
refocuses the @13C chemical shifts (@ref{fig:ref-inept_ref-inept_step2}).
Thereafter, we'll apply the two @p180 pulses.

@eq[env=align*]{
  \xrightarrow{\mathmakebox[7em]{\Delta_2}} &
    @termb{-2 H_z C_y} \cos (\pi @Jch \Delta_2) +
    @termb{C_x} \sin (\pi @Jch \Delta_2) @eqbreak
  \xrightarrow{\mathmakebox[7em]{@p180x1H,\ @p180x13C}}
  &
  @termb{-2 H_z C_y} \cos (\pi @Jch \Delta_2) +
  @termb{C_x} \sin (\pi @Jch \Delta_2)
}

@marginfig[id=fig:ref-inept_ref-inept_step2]{
    @asy{
      include pulseseq;
      PulseSeq ps = PulseSeq('1H', '13C');

      ps.add(1, Hard90());
      ps.add(1, Delay("$\Delta_1$"));
      ps.add(1, Hard180(), 2, Hard180());
      ps.add(1, Delay("$\Delta_1$"));
      ps.add(1, Hard90(Label("y")), 2, Hard90());
      ps.add(2, Delay("$\Delta_2$", highlight=true));
      ps.add(1, Hard180(), 2, Hard180(highlight=true));
      ps.add(2, Delay("$\Delta_2$"));
      ps.add(2, Fid(2, cosmod=true));
      ps.draw();
  }
  @caption{The second step of the refocused INEPT sequence highlighted
   in red.}
}

The final and third step (@ref{fig:ref-inept_ref-inept_step3}) propagates
the magnetization with another @term{\Delta_2} period.

@eq[env=align*]{
\xrightarrow{\mathmakebox[7em]{\Delta_2}}&
  - @termb{2 H_z C_y} \cos (\pi @Jch \Delta_2) \cos(\pi @Jch \Delta_2) \\
  &
  + @termb{C_x} \cos (\pi @Jch \Delta_2) \sin(\pi @Jch \Delta_2) \\
  &
  + @termb{C_x} \sin (\pi @Jch \Delta_2) \cos (\pi @Jch \Delta_2) \\
  &
  + @termb{2 H_z C_y} \sin (\pi @Jch \Delta_2) \sin (\pi @Jch \Delta_2) @eqbreak
  =&
  - @termb{2 H_z C_y} \cos(\pi @Jch 2 \Delta_2) + @termb{C_x} \sin(2 \pi @Jch \Delta_2)
}

@marginfig[id=fig:ref-inept_ref-inept_step3]{
  @asy{
    import pulseseq;
    PulseSeq ps = PulseSeq('1H', '13C');

    ps.add(1, Hard90());
    ps.add(1, Delay("$\Delta_1$"));
    ps.add(1, Hard180(), 2, Hard180());
    ps.add(1, Delay("$\Delta_1$"));
    ps.add(1, Hard90(Label("y")), 2, Hard90());
    ps.add(2, Delay("$\Delta_2$"));
    ps.add(1, Hard180(), 2, Hard180());
    ps.add(2, Delay("$\Delta_2$", highlight=true));
    ps.add(2, Fid(2, cosmod=true));
    ps.draw();
  }
  @caption{The third step of the refocused INEPT sequence highlighted in red.}
}

The @termb{C_x} term is maximum when @term{\Delta_2 = (4 @Jch)^{-1}}. As with
the @abbrv{INEPT} sequence, the @termb{C_x} magnetization is enhanced by a
factor @term{\frac{K_H}{K_C}} over the unenhanced version.

For a @13C-INEPT between for a @1H spin bonded to
a @13C (@Jch = 145 Hz), the magnetization after the
@abbrvINEPT is @termb{2 H_z C_y}. The refocused @abbrv{INEPT} experiment
produces in-phase magnetization, @termb{C_x}, suitable for @1H
decoupling (@ref{fig:inept_inept_v_refinept}).

@figure[id=fig:inept_inept_v_refinept]{
  @panel[width="30%"]{
    a. Magnetization after INEPT
    @asy[width="90%"]{media/asy/ref-inept/CH_before.asy}
  }
  @panel[width="30%"]{
    b. Magnetization after ref-INEPT
    @asy[width="90%"]{media/asy/ref-inept/CH_after.asy}
  }
  @panel[width="33%"]{
    c. Comparison of Spectra
    @img[width="100%"]{media/plots/ref-inept/inept_vs_ref_inept.pdf}
  }
  @caption{Comparison of the @abbrv{INEPT} sequence and the refocused
    @abbrv{INEPT} sequence for a @CH group.}
}

@subsection{Cosine and Sine Modulation}

@subsection{Methylene, Methyl, AX2 and AX3 Spin Systems}

Different @term{\Delta_2} periods emphasize different types of spin
systems. Varying @term{\Delta_2} periods is commonly used to differentiate
between @CH, @CH2 and @CH3 groups. This principal applies to
other X spins, such as @15N, but in the case of
NH@sub{2} and NH@sub{3} groups, rapid hydrogen
exchange with the solvent may impede the discrimination between these groups.

The initial @abbrv{INEPT} period behaves the same for @CH, @CH2 and
@CH3 groups. This is because each @1H spin is only bonded to
one @13C spin.

Once the magnetization is converted to transverse magnetization for
the @13C spin, the magnetization evolves with J-couplings to
multiple @1H spins during the rest of the refocused INEPT. This
is because, from the @13C spin's perspective, a CH group
appears as a doublet, a @CH2 group appears as a triplet and a @CH3
group appears as a quartet.

The conversion to @termb{C_x} magnetization follows different time
dependencies for the @CH (AX), @CH2 (AX2) and @CH3 (AX3) groups.
