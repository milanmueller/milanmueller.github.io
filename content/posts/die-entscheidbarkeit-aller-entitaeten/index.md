+++
title = "Die Entscheidbarkeit aller Entitäten"
date = "2025-05-17"

[taxonomies]
tags=["memes"]

[extra]
repo_view = true
comment = true
+++

_Disclaimer: Der Nachfolgende Text erhebt keinerlei Anspruch auf formale Korrektheit oder gar Sinnhaftigkeit._

# Einleitung
Man betrachte das nachfolgende Meme:

<div style="display: block; margin-left: auto; margin-right: auto; width: 14em;">
  <img src="./duck.jpg" alt="Every single thing that exists in this infinite universe is either a duck or not a duck">
</div>

Auf den ersten Blick erscheint die Aussage offensichtlich wahr zu sein, schließlich gibt es ja nur zwei Möglichkeiten; Ente oder nicht Ente.
Als FOL[^1]-Formel könnte die Aussage wie folgt formalisiert werden:
$$
  \forall x . Ente(x) \lor \lnot Ente(x)
$$
In natürlicher Sprache wäre dies etwa "Für jedes Objekt $x$ gilt: $x$ is eine Ente ODER $x$ ist keine Ente".<br>
Es handelt sich hierbei um eine Instanz des Satzes des ausgeschlossenen Dritten, nach welchem jede beliebige Aussage (wie hier etwa $Ente(x)$) entweder wahr oder falsch sein muss.
Tatsächlich aber waren sich aber auch schlaue Menschen nicht ganz einig, ob das so überhaupt stimmt[^2].
Ob nun wirklich jedes Objekt im Universum eine Ente ist oder nicht, ist vielleicht gar nicht so eindeutig mit "Ja" zu beantworten.

# Eine Frage der Interpretation
Selbst wenn das Dritte nicht ausgeschlossen werden kann, könnte man argumentieren, dass eine Ente ja recht wohldefiniert sein sollte.
Sofern uns eine Definition der Ente bekannt ist welche für jedes beliebige Objekt $x$ die Entenfrage entscheidet, dann können wir dem humoristischen Aspekt des dargestellten Memes endlich auch ohne erkenntnistheoretische Gewissensbisse frönen.

Wikipedia[^3] macht es natürlich wieder kompliziert und bietet gleich mehrere Interpretationen einer "Ente" an (darunter u.a. verschiedene "Entenvögel", Fahr- und Flugzeuge und einen Fußballspieler namens "Willi Lippens"). Bei dem im Meme abgebildeten Entenvogel handelt es sich, meiner absolut unqualifizierten Klassifizierung nach, wohl um eine "Hausente"[^4] welche wiederum eine Art Spezialisierung einer "Stockente" darstellt.

An diesem Punkt nimmt das Unheil bereits seinen Lauf. Betrachten wir die Mengen $Hausente \subseteq M$ und $Stockente \subseteq M$, so besteht eine Teilmengenrelation $Hausente \subsetneq Stockente$. Ein nicht domestizierte Ente $x$ läge in der Mengendifferenz $Stockende \setminus Hausente$.
Die Person, die das Meme erstellt hat, hat es schändlicherweise vernachlässigt eine genaue Spezifikation einer Ente beizufügen.
Es besteht also ein gewisser Interpretationsspielraum und wir könnten "Ente" sowohl auf $Stockente$ als auch auf $Hausente$ beziehen (oder auf irgendwelche Fußballspieler, aber darauf verzichte ich hier).

Wagen wir ein Gedankenexperiment: Alice und Brittany haben einen gemeinsamen Sohn Charlie. Alice geht von der Mengengleichheit $Ente = Hausente$ aus, während Brittany der Überzeugung ist $Ente = Stockente$.<br>
Sohn Charlie lernt neues, indem er Klassifizierung seiner Eltern übernimmt und auf die von ihm wahrgenommene Welt anwendet. Wir versuchen nun, uns in Charlie hineinzuversetzen.<br>
Eines Tages besucht die Familie einen See in welchem (nicht domestizierte) Enten schwimmen. Charlie sieht hier zum ersten Mal in seinem Leben eine Ente.
Da Charlie eine extrem gute Intuition hat, fragt er "Ist das eine Ente?".
Logischerweise antwortet Alice mit "Nein", während Brittany gleichzeitig mit "Ja" antwortet.
Im nächsten Moment werden sowohl Alice als auch Brittany zufällig von einem Blitz getroffen und sind auf der Stelle tot.

Nun passieren schlimme Dinge. Sei $x \in M$ die (nicht domestizierte) Ente welche Charlie auf dem See gesehen hat.
Für Charlies Interpretation einer $Ente$ gilt nun
$$
  Ente(x) \land \lnot Ente(x)
$$
Daraus leitet er sich folgerichtig ab
$$
\begin{align}
  Ente(x) \land \lnot Ente(x) &\vdash Ente(x) \\\\
  Ente(x) \land \lnot Ente(x) &\vdash \lnot Ente(x) \\\\
  Ente(x) &\vdash Ente(x) \lor Gottheit(x) \\\\
  Ente(x) \lor Gottheit(x), \lnot Ente(x) &\vdash Gottheit(x)
\end{align}
$$
In natürlicher Sprache könnte diese Herleitung etwa so funktionieren
1. Das Tier, das Charlie gesehen hat, _ist eine Ente_ (denn das hat Brittany gesagt). Das Tier, das Charlie gesehen hat, ist auch _nicht eine Ente_ (denn das hat Alice gesagt). Die Aussagen _das Tier ist eine Ente_ und _das Tier ist nicht eine Ente_ sind also jeweils wahr.
2. Wenn das Tier eine Ente ist, dann ist folgendes korrekt: _Das Tier ist eine Ente ODER das Tier ist eine Gottheit_.
3. Aus 1. wissen wir _das Tier ist keine Ente_ und aus 2. wissen wir _das Tier ist eine Ente ODER das Tier ist eine Gottheit_. Aus den beiden Aussagen folgt: _Das Tier ist eine Gottheit_.

Charlie gründet in der Folge eine fundamentalistische Sekte. Alle Menschen die seinen Glauben an die schwimmende Gottheit nicht teilen, gelten als Ungläubige und müssen von der Sekte bestraft (im Sinne von getötet) werden. Charlie geht als blutrünstiger Fanatiker in die Geschichte ein.

Genau deshalb sind präzise Spezifikationen wichtig.[^5]

# Die UnENTscheidbarkeit des UnENTlichen

Nun könnte man natürlich sagen, dass dies ja ein sehr konstruiertes Beispiel ist und man sich im Großen und Ganzen schon recht einig ist, was man sich unter einer "Ente" vorstellen kann.
Wählen wir also die Definition einer Stockente[^6] (_Anas platyrhynchos_) und nehmen großzügigerweise an, die gesamte Menschheit würde sich auf diese Definition als die allgemeine Definition einer Ente einigen (nebenbei bemerkt eine wirklich sehr großzügige Annahme, dass sich die gesamte Menschheit überhaupt auf irgendetwas einigen könnte).<br>
Wie es scheint (ich habe keine Ahnung von allem, was kein Computer ist) lässt sich die Definition einer Stockente als große Konjunktion von weiteren Definitionen darstellen, etwa (ohne Anspruch auf Eindeutigkeit oder Vollständigkeit)
$$
\begin{align*}
  Stockente(x)  := &Entenvogel(x) \\\\
                \land &Länge(x) \leq 58cm \\\\
                \land &Flügelspannweite(x) \leq 95cm \\\\
                &\dots \\\\
\end{align*}
$$
In natürlicher Sprache etwa:<br>
Objekt $x$ ist eine Stockente wenn
* $x$ ein Entevogel ist UND
* $x$ eine Länge von 58cm oder weniger hat UND
* $x$ eine Flügelspannweite von 95cm oder weniger hat UND
* ... (weitere Attribute von Stockenten)

Wir nehmen hier an, dass diese Definition tatsächlich so genau ist, dass für jedes Tier auf der Erde entschieden werden kann, ob es sich nun um eine Ente handelt oder nicht.

Ein weiteres Gedankenexperiment: Im Jahr 2042 entdeckt die Menschheit einen erdähnlichen Planeten (nennen wir ihn "Dennis") und kann diesen sogar bereisen. Auf dem Planeten findet sich eine Lebensform bei der alle Teildefinitionen der obigen Konjunktion zutreffen. Folglich haben wir auf dem neu entdeckten Planeten "Dennis" Enten gefunden. Welch freudiges Ereignis.

Nach einer Weile bemerken wir jedoch, dass die Enten auf "Dennis" Gedanken lesen können. In unserer bisherigen Definition einer Ente hatten wir die Frage, ob Gedankenlesen eine Eigenschaft von Enten ist, nicht berücksichtigt, da es keinen Anlass dazu gab.
Nach langer Diskussion entscheiden wir, dass die Fähigkeit Gedanken zu lesen derart signifikant ist, dass die neue Lebensform nicht als "Ente" klassifiziert werden sollte, sondern dass wir lieber eine andere Bezeichnung wählen sollten. Etwa "gedankenlesende Ente".
Wir erweitern also unsere Definition der (normalen) Ente um $\lnot Gedankenlesen(x)$ und können fortan zwischen den Enten der Erde und den gedankenlesenden Enten auf "Dennis" unterscheiden.

Im Jahre 2142 findet die Menschheit einen weiteren Planeten - "Dennis 2". Hier findet sich schon wieder eine neue Spezies die unseren irdischen Enten sehr ähnlich ist (in dem Sinne, dass alle Konjunkte bejaht werden können).
Nach einigen Untersuchungen stellen wir dann auch erleichtert fest: Die neue Spezies kann keine Gedanken lesen. Wir haben nun also auf "Dennis 2" tatsächlich Enten gefunden.
Welch freudiges Ereignis.

Aber dann kommt der Plottwist: Die Enten auf "Dennis 2" können zwar keine Gedanken lesen, aber sie können Teleportieren.
Auch hier fällen wir wieder die Entscheidung: Eine normale Ente sollte nicht teleportieren können.
Wir erweitern also erneut unsere Konjunktsammlung um $\lnot Teleportieren(x)$.

Man kann sich vielleicht denken wie es weiter geht: Wir finden immer neue Planeten mit immer neuen entenartigen Geschöpfen, jeweils mit einer neuen bis dato nicht berücksichtigten Eigenschaft.
Bis wir den jeweils nächsten Planeten finden, erschien uns unsere Definition ausreichend um Enten eindeutig klassifizieren zu können. Bei den nächsten Superenten merken wir dann aber, dass unsere Definition zu ungenau war.

Halten wir nun einen Moment fest, zu dem wir noch überzeugt sind, dass unsere Entendefinition gut genug ist, um Ente von Nicht-Ente zu unterscheiden.
In Kürze werden wir eine weitere Nicht-Ente finden die wir bislang noch nicht kennen. z.B. die "Wasser in Wein verwandelnde Ente".<br>
Die "Wasser in Wein verwandelnde Ente" existiert zum aktuellen Zeitpunkt bereits, wir kennen sie aber noch nicht. Hätten wir sie gekannt, dann wäre uns vielleicht klar, dass sie keine Ente sein kann.

Was ist nun die "Wasser in Wein verwandelnde Ente"? Nach unserer aktuellen Definition ist sie eine Ente, aber wenn wir sie bereits kennen würden, wären wir uns sicher dass sie keine Ente ist.
Tragischerweise kann unsere Entendefinition nie gut genug sein. Wir sind zu der Annahme verdammt, dass es irgendwo da drausen Wesen gibt, die zwar irgendwie keine Ente sind, die aber bis jetzt unter unsere Definition einer Ente fallen. Und das schlimmste ist: Wir wissen noch nicht einmal warum.

Ganz entscheidend ist hier auch, dass im Meme weiter oben vom _unendlichen_ Universum die Rede ist. In einem endlichen Universum könnte man argumentieren, dass es ein Konjunkt gibt, das mächtig genug ist, um unsere Enten auf der Erde von den extraterrestrischen Enten zu unterscheiden.
Also dass wir nur lang genug nach neuen Nicht-Enten suchen müssen bis wir alle gefunden haben.
Wenn wir aber davon ausgehen, dass unser Universum unendlich groß ist, dann wird unser Gedankenexperiment nie enden und unsere Entendefinition wird niemals gut genug sein, um die Entenfrage auch für alle noch unbekannten Lebensformen zu entscheiden.

Die einzige Logische Schlussfolgerung ist also Resignation.<br>
Wenn die Außerirdischen zum ersten mal mit uns sprechen, dann werden Sie uns fragen "was ist eine Ente?"<br>
Zur Antwort werden wir verzweifelt zusammenbrechen. "Wir wissen es nicht! Wir können es niemals wissen! Existens ist Schmerz!" werden wir wehklagen.

# Fazit
Aus Sicht des Formalismus hätte ich mir die Gedankenexperimente sparen können (die Frage, ob das nicht ohnehin besser gewesen wäre, sei den Lesenden überlassen). 
Ob nun der Formalismus oder Intuitionismus "besser" sind, das kann ich als mittelmäßiger Hobbylogiker unmöglich beurteilen.
Was der obige Nonsens aus meiner Sicht aber unterstreicht, ist die Sinnlosigkeit der Anwendung formaler Logik auf selbst triviale Fragen wie "ist jedes Objekt entweder eine Ente oder nicht eine Ente?" Da mit recht simplen formalen Tricks alles in einem fatalistischen "eigentlich haben wir keine Ahnung" endet.

Im Falle der Ente gibt es kaum Kontroversen um die Definition derselben (und wenn doch, ist mir dieses Highlight der menschlichen Streitsucht wohl entgangen).
Betrachtet man jedoch einen Begriff der auch nur im entferntesten politisierbar ist, dann findet man mit Leichtigkeit ausschweifende Debatten, die allein aufgrund uneinheitlicher Auffassung der Semantik des Begriffs zur Destruktivität (im Sinne von Abwesenheit von Konstruktivität (im Sinne von "auf einen gemeinsamen Nenner kommen")) verdammt sind.

Wenn sich aber formale Logik nicht auf alltägliche Fragen anwenden lässt, wie können wir überhaupt an eine "Wahrheit" glauben? Hier ein Vorschlag: Wir glauben einfach an irgendeinen Gott und denken uns dazu noch ein Ethikkonzept aus, durch welches wir dann all unsere Handlungen als legitimiert betrachten. Als Vorschlag für einen solchen Gott möchte ich zusätzlich noch die Ente vom Ententeich in den Ring werfen.

Ente gut alles gut.

---

# Fußnoten / Quellen
[^1]: [First-order logic - Wikipedia](https://en.wikipedia.org/wiki/First-order_logic)
[^2]: [Brouwer-Hilbert controversy - Wikipedia](https://en.wikipedia.org/wiki/Brouwer%E2%80%93Hilbert_controversy)
[^3]: [Ente - Wikipedia](https://de.wikipedia.org/wiki/Ente)
[^4]: [Hausente - Wikipedia](https://de.wikipedia.org/wiki/Hausente)
[^5]: Genau genommen gibt es wahrscheinlich noch weitere, weniger drastische Beispiele für die Wichtigkeit von präzisen Spezifikationen in passenden Kontexten.
[^6]: [Stockente - Wikipedia](https://de.wikipedia.org/wiki/Stockente)

