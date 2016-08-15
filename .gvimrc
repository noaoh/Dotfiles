set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'pangloss/vim-javascript'
"Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'rosenfeld/conque-term'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-auto-save'
"Plugin 'scrooloose/syntastic'
Plugin 'kovisoft/slimv'
Plugin 'mtth/scratch.vim'
Plugin 'elzr/vim-json'
Plugin 'hylang/vim-hy'
call vundle#end()
filetype plugin indent on


let mapleader = ";"
let localleader = ";;"

set noswapfile

"Abbreviations
ab slef self
ab ident indent
ab tat that
ab teh the
ab te the
ab tis this
ab abs absolute
ab vol volume
ab vols volumes 
ab cs computer science
ab algo algorithm
ab algos algorithms
ab dt data
ab struct structure 
ab structs structures
ab approx approximately
ab ea each
ab fr for
ab gen general
ab lib library
ab pt point
ab thru through
ab vv very
ab sim similar
ab simu simulation
ab conf conference
ab econ economy
ab esp especially
ab sch school
ab hm home
ab wr work
ab lang language 
ab usu usually
ab poss possible 
ab info information
ab hv have
ab rng range
ab lp loop
ab orig original
ab sect section
ab bin binary
ab bit binary digit
ab dig digit
ab prog program
ab lnx linux
ab thr thread
ab thrs threads
ab pln plane
ab sep separate 
ab jv java
ab py python
ab rb ruby
ab nt not
ab tn then
ab ys yes
ab assoc association 
ab tho though 
ab altho although
ab hw how
ab hwe however
ab yu you
ab ar are
ab govt government
ab ser series
ab vs versus
ab univ university
ab univs universities
ab rt root
ab rts roots
ab sq square 
ab sqs squares
ab rect rectangle 
ab rects rectangles
ab tri triangle
ab tris triangles
ab eqs equals
ab eqt equal to
ab gt greater than
ab lt less than
ab sec second
ab secs seconds
ab adj adjective 
ab adv adverb
ab advt advertisement
ab cem cement
ab agri agriculture 
ab bef before
ab aft after
ab chg change
ab compar comparative
ab conj conjuction
ab cpd compound
ab deriv derivative
ab integ integral
ab engin engineering
ab imp imperative 
ab ind indicative
ab inf infinitive
ab knowl knowledge
ab man manual
ab mem memory
ab obj object
ab objct objective
ab les lesson
ab per person
ab phr phrase
ab pref prefix
ab propr property
ab proprs properties
ab prob probability
ab proba probably
ab priv private
ab pub public 
ab refl reflexive
ab rel relative
ab al all
ab spec specification
ab subj subject
ab subjc subjective
ab syll syllable
ab techn technical
ab ther theory
ab theoret theoretical
ab hypot hypothesis
ab typog typography
ab vb verb 
ab wd word
ab abstr abstract
ab conc concrete 
ab addr address
ab advoc advocate
ab agst against 
ab agn again
ab stat statistics
ab evid evidence
ab analy analysis 
ab ans answer
ab argt argument
ab argts arguments
ab bt between
ab curr current
ab para paradigm
ab vw view
ab vwp viewpoint
ab cent central
ab cmp compare
ab cont continue
ab contd continued
ab char character
ab chars characters
ab chem chemical
ab chems chemicals
ab circ circle
ab cla class
ab combin combination
ab permu permution
ab confl conflict
ab congr congress
ab discu discussion
ab elem element
ab enq enquiry
ab epil epilogue
ab equiq equipment
ab evol evolution
ab exch exchange
ab explan explanation
ab fam family
ab frag fragment
ab fut future
ab gr great 
ab kpr keeper
ab lect lecture
ab lects lectures
ab magn magnet
ab meth method
ab meths methods
ab modn modern
ab mt mountain 
ab navig navigation
ab nerv nervous 
ab obed obedience
ab org organization
ab outl outline
ab pa past
ab perf perfect
ab pseu pseudo
ab sel select
ab seld selected
ab sev several
ab sing singular
ab sp spelling
ab syst system
ab bk book
ab trig trigonometry
ab ult ultimately
ab util utility
ab utils utilities 
ab utilit utilitarian
ab vari variant
ab lat later 
ab abl able
ab acct account
ab actu actual
ab alm almost 
ab alng along
ab agr agree
ab agnt agent
ab alr alright
ab amo amount
ab appa apparent
ab appe appear
ab appo appoint
ab arra arrange
ab appr appropriate 
ab aro around 
ab assu assume
ab bala balance
ab bs base
ab bas basis 
ab bea beauty
ab bc because
ab bec become
ab bnd behind
ab bel believe
ab bene benefit 
ab bld blood 
ab bh both
ab bott bottom
ab brk break
ab keyb keyboard
ab brd board
ab bril brilliant 
ab botl bottle
ab crr carry
ab cntl control
ab defi definite
ab dept department 
ab desc describe
ab descr description
ab enc encourage
ab exer exercise
ab exc excuse
ab ex example
ab fin final
ab grn grand
ab grt grant
ab kno know
ab nxt next
ab sci science
ab o or
ab chan channel

"""Text settings"""
set expandtab
set textwidth=79
"set tabstop=8
"set softtabstop=4
"set shiftwidth=4
"font size and type
set guifont=Courier\ Prime\ Code\ 10
set autoindent
set number

"""Insert mode mappings"""
inoremap jj <esc>
"Completion mode
inoremap <leader>n <c-n>
inoremap <leader>p <c-p>
"Do normal command
inoremap <leader>o <c-o>

"""Normal mode mappings"""
nnoremap <leader>r <c-r>
nnoremap <leader>h ^ 
nnoremap <leader>l $
""Search settings/mappings
set hlsearch
set incsearch
"switch off highlighting
nnoremap <leader>W :noh<cr>
""Buffer mappings""
nnoremap <leader>b^ <c-^>
nnoremap <leader>b# :execute "rightbelow vsplit " . bufname("#")
""Window mappings""
nnoremap <leader>w <c-w>
nnoremap <leader>h# :sp #<cr>
nnoremap <leader>v# :vsp #<cr>
""Tab mappings""
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>te :tabe
nnoremap <leader>tc :tabc<cr>
nnoremap <leader>tm :tabmove
""Text openers""
nnoremap <leader>ev :vsplit ~/.gvimrc<cr>
nnoremap <leader>et :vsplit ~/Dropbox/todo/todo.txt<cr>
nnoremap <leader>ei :vsplit ~/Dropbox/writings/ideas.md<cr>
nnoremap <leader>ej :vsplit ~/Dropbox/writings/jokes.md<cr>

"""Plugin mappings"""
""ConqueTerm""
nnoremap <leader>th :ConqueTermSplit 
nnoremap <leader>tv :ConqueTermVSplit 
nnoremap <leader>tt :ConqueTermTab 
""NERDTree""
nnoremap <leader>nl :NERDTree ~/Dropbox/learnprogramming<cr>
nnoremap <leader>nm :NERDTree ~/MyProjects<cr>
nnoremap <leader>no :NERDTree ~/OthersProjects<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
""Syntastic""
"Compiler
nnoremap <leader>pv :PluginInstall<cr>
nnoremap <leader>sv :source ~/.gvimrc<cr>

let g:auto_save = 1
colorscheme solarized

""autogroups""
