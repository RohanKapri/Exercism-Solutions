import java.util.*;
public class Camicia {
    private static final String FINISHED = "finished";
    private static final String LOOP = "loop";
    public static CamiciaResult simulateGame(List<String> pA, List<String> pB) {
        List<String> playerA = new ArrayList<>(pA);
        List<String> playerB = new ArrayList<>(pB);
        List<String> stack = new ArrayList<>();
        int gameTricks = 0;
        int totalCardsPlayed = 0;
        int totalCards = playerA.size() + playerB.size();
        List<String> penalty = List.of("0", "J", "Q", "K", "A");
        String turn = "A";
        Set<String> visitedStates = new HashSet<>();
        while (!playerA.isEmpty() || !playerB.isEmpty()) {
            String state = getSignature(playerA, playerB, turn);
            if (visitedStates.contains(state)) {
                return new CamiciaResult(LOOP, totalCardsPlayed, gameTricks);
            }
            visitedStates.add(state);
            String card;
            if (turn.equals("A")) {
                card = playerA.isEmpty() ? null : playerA.removeFirst();
            } else {
                card = playerB.isEmpty() ? null : playerB.removeFirst();
            }
            if (card == null) {
                List<String> winner = turn.equals("A") ? playerB : playerA;
                winner.addAll(stack);
                stack.clear();
                gameTricks++;
                break;
            }
            totalCardsPlayed++;
            stack.add(card);
            int penaltyIndex = penalty.indexOf(card);
            if (penaltyIndex > 0) {
                boolean isPenaltyActive = true;
                String target = turn.equals("A") ? "B" : "A";
                int count = penaltyIndex;
                while (isPenaltyActive) {
                    boolean responded = false;
                    for (int i = 0; i < count; i++) {
                        String pCard;
                        if (target.equals("A")) {
                            pCard = playerA.isEmpty() ? null : playerA.removeFirst();
                        } else {
                            pCard = playerB.isEmpty() ? null : playerB.removeFirst();
                        }
                        if (pCard == null) {
                            isPenaltyActive = false;
                            break;
                        }
                        totalCardsPlayed++;
                        stack.add(pCard);
                        int newPenalty = penalty.indexOf(pCard);
                        if (newPenalty > 0) {
                            count = newPenalty;
                            target = target.equals("A") ? "B" : "A";
                            responded = true;
                            break;
                        }
                    }
                    if (!responded) {
                        isPenaltyActive = false;
                        String winnerName = target.equals("A") ? "B" : "A";
                        if (winnerName.equals("A")) {
                            playerA.addAll(stack);
                        } else {
                            playerB.addAll(stack);
                        }
                        stack.clear();
                        gameTricks++;
                        turn = winnerName;
                    }
                }
            } else {
                turn = turn.equals("A") ? "B" : "A";
            }
            if (playerA.size() == totalCards || playerB.size() == totalCards) {
                break;
            }
        }
        if (!stack.isEmpty()) {
            gameTricks++;
            List<String> winner = playerA.isEmpty() ? playerB : playerA;
            winner.addAll(stack);
        }
        boolean isLoop =
                playerA.size() != totalCards &&
                        playerB.size() != totalCards;
        return new CamiciaResult(
                isLoop ? LOOP : FINISHED,
                totalCardsPlayed,
                gameTricks
        );
    }
    private static String getSignature(
            List<String> deckA,
            List<String> deckB,
            String currentTurn
    ) {
        return norm(deckA) + "|" + norm(deckB) + "|" + currentTurn;
    }
    private static String norm(List<String> deck) {
        StringBuilder sb = new StringBuilder();
        for (String card : deck) {
            if (card.matches("^\\d+$")) {
                sb.append("N");
            } else {
                sb.append(card);
            }
        }
        return sb.toString();
    }
}
