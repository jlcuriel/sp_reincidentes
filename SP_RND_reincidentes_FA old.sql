U S E   [ R N D e t e n c i o n e s _ f a ] 
 G O 
 
 / * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ R N D _ r e i n c i d e n t e s _ F A ]         S c r i p t   D a t e :   1 6 / 0 1 / 2 0 2 4   1 2 : 2 3 : 4 4   p .   m .   * * * * * * / 
 S E T   A N S I _ N U L L S   O N 
 G O 
 
 S E T   Q U O T E D _ I D E N T I F I E R   O N 
 G O 
 
 A L T E R   P R O C E D U R E   [ d b o ] . [ S P _ R N D _ r e i n c i d e n t e s _ F A ] 
 @ i d e s t a d   i n t , 
 @ f e c f i n   d a t e 
 
 W I T H   E X E C   A S   C A L L E R 
 A S 
 
 B E G I N 
 
 - -   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
 - -   A u t o r :   J L C R 
 - -   F e c h a   d e   c r e a c i � n :   E n e r o   2 0 2 4 
 - -   F e c h a   d e   m o d i f i c a c i � n : 
 - -   D e s c r i p c i � n :   G e n e r a   r e s u m e n   d e   d e t e n i d o s   R e i n c i d e n t e s   e n   F a l t a s   A d m i n i s t r a t i v a s ,   a   p a r t i r   d e l   r a n g o   d e   F e c h a   
 - -   d a d a   s e   c a l c u l a   u n   a � o   a t r a s   p a r a   l a   c o n s u l t a 
 - -   F e c h a   M o d i f i c a c i � n :   2 2   E N E   2 4 ,   s e   e l i m i n a   l a   l i g a   c o n   l a   t a b l a   " T D E T E N I D O S A D I C C I O N E S " ,   d e   l o s   t a b l e r o s 
 - - = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
 
 B E G I N   T R Y 
 
 D E C L A R E   @ f e c i n i   d a t e ; 
 
 S E T   @ f e c i n i   =   D A T E A D D ( y e a r ,   - 1 ,   @ f e c f i n ) 
  
 I F   O B J E C T _ I D ( N ' t e m p d b . d b o . # T e m r e g t o t e d o ' ,   N ' U ' )   I S   N O T   N U L L      
       D R O P   T A B L E   # T e m r e g t o t e d o ; 
 
 I F   O B J E C T _ I D ( N ' t e m p d b . d b o . # r e g t o t e d o ' ,   N ' U ' )   I S   N O T   N U L L     
       D R O P   T A B L E   # r e g t o t e d o ; 
 
 I F   O B J E C T _ I D ( N ' t e m p d b . d b o . # T o p R e g D u p l i c a d o s ' ,   N ' U ' )   I S   N O T   N U L L      
       D R O P   T A B L E   # T o p R e g D u p l i c a d o s ; 
 
 
 
 I F   O B J E C T _ I D ( N ' t e m p d b . d b o . # T a b l a N o m E s t a t u s ' ,   N ' U ' )   I S   N O T   N U L L     
 
       D R O P   T A B L E   # T a b l a N o m E s t a t u s ; 
 
 
 
 S E L E C T   R O W _ N U M B E R ( )   O V E R ( O R D E R   B Y   d . i d _ d e t e n i d o   A S C )   A S   r e g ,   e . N O M B R E   e n t i d a d ,   m . N O M B R E   m u n i c i p i o 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , d t . l u g a r _ d e t e n c i o n ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   l u g a r _ d e t e n c i o n 
 
 ,   d . i d _ d e t e n i d o 
 
 ,   d . f o l i o _ d e t e n i d o 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( d . n o m b r e ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   n o m b r e 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( d . a p e l l i d o _ p a t e r n o ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   a p e l l i d o _ p a t e r n o 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( d . a p e l l i d o _ m a t e r n o ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   a p e l l i d o _ m a t e r n o 
 
 ,   d t . f e c h a _ d e t e n c i o n 
 
 ,   d c . c u r p 
 
 ,   e 1 . N O M B R E   e n t i d a d _ d o m 
 
 ,   m 1 . N O M B R E   m p i o _ d o m 
 
 ,   l o c . n o m b r e   l o c a l i d a d _ d o m 
 
 ,   c o l . N O M B R E   c o l o n i a _ d o m 
 
 ,   d c . n u m e r o _ i n t e r i o 
 
 ,   d c . n u m e r o _ e x t e r i o r 
 
 ,   d c . c o d i g o _ p o s t a l 
 
 ,   c m c . m o t i v o _ c o n c l u s i o n _ r i 
 
 ,   d . d e s c r i b e _ m o t i v o _ c o n c l u s i o n   
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( 
 
         U P P E R ( p . n o m b r e _ o f i c i a l _ r e c i b e ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) 
 
         , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   M P 
 
 ,   ( S E L E C T   S T U F F ( 
 
             ( s e l e c t   ' ,   '   +   
 
                         R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( b . a p e l l i d o _ p a t e r n o   
 
                                 +   '   '   +   b . a p e l l i d o _ m a t e r n o     +   '   '   +   b . N o m b r e ) 
 
                                 ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' ) 
 
                 f r o m   R N D e t e n c i o n e s _ f a . d b o . o f i c i a l e s _ f a   b   
 
                 w h e r e   b . i d _ d e t e n c i o n   =   d . i d _ d e t e n c i o n 
 
                         F O R   X M L   P A T H   ( ' ' ) ) , 
 
                 1 , 2 ,   ' ' ) )   o f i c i a l 
 
 ,   ( S E L E C T   S T U F F ( 
 
             ( S E L E C T   ' ,   '   +   
 
                         R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( b . p a t e r n o   
 
                                 +   '   '   +   b . m a t e r n o     +   '   '   +   b . N o m b r e ) 
 
                                 ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' ) 
 
                 f r o m   R N D e t e n c i o n e s _ f a . d b o . o f i c i a l e s _ P S P _ f a   b   
 
                 w h e r e   b . i d _ d e t e n c i o n   =   d . i d _ d e t e n c i o n 
 
                         F O R   X M L   P A T H   ( ' ' ) ) , 
 
                 1 , 2 ,   ' ' ) )   o f i c i a l _ p s p 
 
 ,   c e d f . d e s c r i p c i o n _ e s t a t u s 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , d t . m o t i v o _ d e t e n c i o n ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   m o t i v o _ d e t e n c i o n 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , c t l . t i p o _ l i b e r t a d ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   t i p o _ l i b e r t a d 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , t r . c a u s a _ l i b e r t a d ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   c a u s a _ l i b e r t a d 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , c t t . n o m b r e _ t i p o _ t r a s l a d o ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   n o m b r e _ t i p o _ t r a s l a d o 
 
 ,   d . f e c h a _ n a c i m i e n t o 
 
 ,   d . e d a d 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( d c . n o m b r e _ d e t e n i d o ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   n o m b r e _ d c 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( d c . a p e l l i d o _ p a t e r n o ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   a p e l l i d o _ p a t e r n o _ d c 
 
 ,   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , r t r i m ( l T R I M ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( r e p l a c e ( U P P E R ( d c . a p e l l i d o _ m a t e r n o ) ,   ' � ' ,   ' A '   ) ,   ' � ' ,   ' E '   ) ,   ' � ' ,   ' I '   ) ,   ' � ' ,   ' O '   ) ,   ' � ' ,   ' U '   ) ) ) ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   a s   a p e l l i d o _ m a t e r n o _ d c 
 
 ,   d c . f e c h a _ n a c i m i e n t o   F e c _ n a c _ d c 
 
 ,   ( S E L E C T   S T U F F ( 
 
         ( S E L E C T   ' ,   '   +   c t d 1 . t i p o _ d e l i t o 
 
                         F R O M   R N D e t e n c i o n e s _ f a . d b o . t r a s l a d o s _ d e l i t o s _ f a   t d 1     
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ s u b t i p o _ d e l i t o _ f a   c s d 1   O N   t d 1 . i d _ s u b t i p o _ d e l i t o   =   c s d 1 . i d _ s u b t i p o _ d e l i t o   
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ t i p o _ d e l i t o _ f a   c t d 1   O N   c t d 1 . i d _ t i p o _ d e l i t o   =   t d 1 . i d _ t i p o _ d e l i t o   A N D   c t d 1 . i d _ b i e n   ! =   0   
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ b i e n e s _ j u r i d i c o s _ f a   c b j 1   O N   c b j 1 . i d _ b i e n   =   t d 1 . i d _ b i e n   
 
                         W H E R E   t d 1 . i d _ t r a s l a d o   =   t r . i d _ t r a s l a d o   
 
                         F O R   X M L   P A T H   ( ' ' ) ) , 
 
                 1 , 2 ,   ' ' ) )   d e l i t o s 
 
 ,   ( S E L E C T   S T U F F ( 
 
         ( S E L E C T   ' ,   '   +   c b j 1 . b i e n _ j u r i d i c o 
 
                         F R O M   R N D e t e n c i o n e s _ f a . d b o . t r a s l a d o s _ d e l i t o s _ f a   t d 1     
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ s u b t i p o _ d e l i t o _ f a   c s d 1   O N   t d 1 . i d _ s u b t i p o _ d e l i t o   =   c s d 1 . i d _ s u b t i p o _ d e l i t o   
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ t i p o _ d e l i t o _ f a   c t d 1   O N   c t d 1 . i d _ t i p o _ d e l i t o   =   t d 1 . i d _ t i p o _ d e l i t o   A N D   c t d 1 . i d _ b i e n   ! =   0   
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ b i e n e s _ j u r i d i c o s _ f a   c b j 1   O N   c b j 1 . i d _ b i e n   =   t d 1 . i d _ b i e n   
 
                         W H E R E   t d 1 . i d _ t r a s l a d o   =   t r . i d _ t r a s l a d o   
 
                         F O R   X M L   P A T H   ( ' ' ) ) , 
 
                 1 , 2 ,   ' ' ) )   b i e n _ j u r i d i c o 
 
 ,   ( S E L E C T   S T U F F ( 
 
         ( S E L E C T   ' ,   '   +   R E P L A C E ( R E P L A C E ( R E P L A C E ( R E P L A C E ( C O N V E R T ( V A R C H A R ( m a x ) , t d 1 . e s p e c i f i q u e _ d e l i t o ) , C H A R ( 1 0 ) , ' ' ) , C H A R ( 9 ) , '   ' ) , C H A R ( 1 3 ) , ' ' ) , ' " ' , '   ' )   
 
                         F R O M   R N D e t e n c i o n e s _ f a . d b o . t r a s l a d o s _ d e l i t o s _ f a   t d 1     
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ s u b t i p o _ d e l i t o _ f a   c s d 1   O N   t d 1 . i d _ s u b t i p o _ d e l i t o   =   c s d 1 . i d _ s u b t i p o _ d e l i t o   
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ t i p o _ d e l i t o _ f a   c t d 1   O N   c t d 1 . i d _ t i p o _ d e l i t o   =   t d 1 . i d _ t i p o _ d e l i t o   A N D   c t d 1 . i d _ b i e n   ! =   0   
 
                         L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ b i e n e s _ j u r i d i c o s _ f a   c b j 1   O N   c b j 1 . i d _ b i e n   =   t d 1 . i d _ b i e n   
 
                         W H E R E   t d 1 . i d _ t r a s l a d o   =   t r . i d _ t r a s l a d o   
 
                         F O R   X M L   P A T H   ( ' ' ) ) , 
 
                 1 , 2 ,   ' ' ) )   e s p e c i f i q u e _ d e l i t o 
 
 	 	 i n t o   # T e m r e g t o t e d o 
 
 F R O M   R N D e t e n c i o n e s _ f a . d b o . d e t e n i d o s _ f a   d   
 I N N E R   J O I N   R N D e t e n c i o n e s _ f a . d b o . d e t e n c i o n e s _ f a   d t   O N   d t . i d _ d e t e n c i o n = d . i d _ d e t e n c i o n 
 I N N E R   J O I N   G e o D i r e c c i o n e s . d b o . E N T I D A D   e   O N   e . I D E N T I D A D   =   d t . i d _ e n t i d a d 
 L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . p u e s t a _ d i s p o s i c i o n e s _ f a   p   O N   p . i d _ d e t e n i d o = d . i d _ d e t e n i d o   A N D   p . e s _ b o r r a d o   =   0   
 L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . d e t e n i d o s _ d a t o s c o m p l e m e n t a r i o s _ f a   d c   O N   d c . i d _ p u e s t a _ d i s p o s i c i o n = p . i d _ p u e s t a _ d i s p o s i c i o n 
 L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . t r a s l a d o s _ f a   t r   O N   t r . i d _ d e t e n i d o _ c o m p l e m e n t o   =   d c . i d _ d e t e n i d o _ c o m p l e m e n t o   A N D   t r . e s _ a c t i v o   =   1 
 L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ t i p o s _ l i b e r t a d e s _ f a   c t l   O N   c t l . i d _ t i p o _ l i b e r t a d   =   t r . i d _ t i p o _ l i b e r t a d 
 I N N E R   J O I N   G e o D i r e c c i o n e s . d b o . M U N I C I P I O   m   O N   m . I D E N T I D A D   =   d t . i d _ e n t i d a d   A N D   m . I D M P I O   =   d t . i d _ m u n i c i p i o 
 I N N E R   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ e s t a t u s _ d e t e n i d o s _ f a   c e d f   O N   c e d f . i d _ e s t a t u s _ d e t e n i d o   =   d . i d _ e s t a t u s _ d e t e n i d o 
 L E F T   J O I N   G e o D i r e c c i o n e s . d b o . E N T I D A D   e 1   O N   e 1 . I D E N T I D A D   =   d c . i d _ e n t i d a d 
 L E F T   J O I N   G e o D i r e c c i o n e s . d b o . M U N I C I P I O   m 1   O N   m 1 . I D E N T I D A D   =   d c . i d _ e n t i d a d   A N D   m 1 . I D M P I O   =   d c . i d _ m u n i c i p i o 
 L E F T   J O I N   G e o D i r e c c i o n e s . d b o . l o c a l i d a d   l o c   O N   l o c . I D E N T I D A D   =   d c . i d _ e n t i d a d   A N D   l o c . I D M P I O   =   d c . i d _ m u n i c i p i o   A N D   l o c . i d l o c   =   d c . i d _ l o c a l i d a d 
 L E F T   J O I N   G e o D i r e c c i o n e s . d b o . c o l o n i a   c o l   O N   c o l . i d c o l o n i a   =   d c . i d _ c o l o n i a 
 L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ t i p o s _ t r a s l a d o s _ f a   c t t   O N   c t t . i d _ t i p o _ t r a s l a d o   =   t r . i d _ t i p o _ t r a s l a d o 
 L E F T   J O I N   R N D e t e n c i o n e s _ f a . d b o . c a t _ m o t i v o s _ c o n c l u s i o n e s _ r i _ f a   c m c   O N   c m c . i d _ m o t i v o _ c o n c l u s i o n _ r i   =   d . i d _ m o t i v o _ c o n c l u s i o n _ r i 
 
 
 
 / * W H E R E   d . i d _ d e t e n i d o   I N   ( 
 
         S E L E C T   t f . i d _ d e t e n i d o   
 
         F R O M   i n d i c a d o r e s _ r n d . d b o . T D E T E N I D O S A D I C C I O N E S   t f   ) * / 
 
 
 
 w h e r e         d t . i d _ e n t i d a d   =   @ i d e s t a d 
 
 A N D   d . e d a d   >   1 7 
 
 A N D   d t . f e c h a _ d e t e n c i o n   > =   @ f e c i n i   A N D   d t . f e c h a _ d e t e n c i o n   < =   @ f e c f i n 
 
 O R D E R   B Y   a p e l l i d o _ p a t e r n o ,   a p e l l i d o _ m a t e r n o ,   n o m b r e , d . f e c h a _ n a c i m i e n t o ; 
 
 
 
 S E L E C T   d . * 
 
 I N T O   # r e g t o t e d o   
 
 F R O M   # T e m r e g t o t e d o   d 
 
 W H E R E     ( d . n o m b r e   ! =   ' S I N   D A T O S ' 
 
 A N D     d . n o m b r e   ! =   ' X ' 
 
 A N D   d . n o m b r e   ! =   ' N ' 
 
 A N D   d . n o m b r e   N O T   L I K E   ' % S I N   D A T O % ' 
 
 A N D   d . n o m b r e   N O T   L I K E   ' % N O   P R O P O R % ' 
 
 A N D   d . n o m b r e   N O T   L I K E   ' % S I N   I N F O R % ' ) 
 
 A N D   L O W E R ( d . m o t i v o _ d e t e n c i o n )   N O T   L I K E   ' % p e n s i % a l i m e n t i c i a ' 
 
 o r d e r   b y   a p e l l i d o _ p a t e r n o ,   a p e l l i d o _ m a t e r n o ,   n o m b r e ,   d . f e c h a _ n a c i m i e n t o ; 
 
 
 
 - - d e t e r m i n a   d e t e n i d o   d u p l i c a d o s   
 
 S E L E C T   n o m b r e ,   a p e l l i d o _ p a t e r n o   , a p e l l i d o _ m a t e r n o ,   f e c h a _ n a c i m i e n t o ,   C O U N T ( 1 )   r e g 
 
 I N T O   # T o p R e g D u p l i c a d o s 
 
 F R O M   # r e g t o t e d o 
 
 G R O U P   B Y   n o m b r e ,   a p e l l i d o _ p a t e r n o   , a p e l l i d o _ m a t e r n o ,   f e c h a _ n a c i m i e n t o 
 
 H A V I N G   C O U N T ( 1 )   >   1 
 
 O R D E R   B Y   5   D E S C ,   2 ,   3 ,   1 ; 
 
 
 
 - - g e n e r a   l i s t a d o   d e   l o s   a c u m u l a d o   p o r   n o m b r e   y   e s t a t u s 
 
 
 
 S E L E C T   T O P   1 0   a . n o m b r e ,   a . a p e l l i d o _ p a t e r n o ,   a . a p e l l i d o _ m a t e r n o , a . f e c h a _ n a c i m i e n t o ,   C O U N T ( 1 )   r e g 
 
 I N T O   # T a b l a N o m E s t a t u s 
 
 F R O M   # r e g t o t e d o   a 
 
 I N N E R   J O I N   # T o p R e g D u p l i c a d o s   b   O N   a . n o m b r e   +   a . a p e l l i d o _ p a t e r n o   +   a . a p e l l i d o _ m a t e r n o   
 
                 =   b . n o m b r e   +   b . a p e l l i d o _ p a t e r n o   +   b . a p e l l i d o _ m a t e r n o 
 
                 A N D   I S N U L L ( a . f e c h a _ n a c i m i e n t o ,   ' ' )   =   I S N U L L ( b . f e c h a _ n a c i m i e n t o ,   ' ' ) 
 
 G R O U P   B Y   a . n o m b r e ,   a . a p e l l i d o _ p a t e r n o ,   a . a p e l l i d o _ m a t e r n o ,   a . f e c h a _ n a c i m i e n t o 
 
 O R D E R   B Y   r e g   D E S C ; 
 
 
 
 S E L E C T   *   F R O M   # T a b l a N o m E s t a t u s ; 
 
 
 
     E N D   T R Y 
 
 
 
         B E G I N   C A T C H 
 
                 E X E C   R e t h r o w E r r o r ; 
 
         E N D   C A T C H 
 
         
 
         S E T   N O C O U N T   O F F 
 
 
 
   E N D ; 
 
 